// sudo apt install libnl-3-dev libnl-genl-3-dev
// sudo apt install libnl-3-dev libnl-genl-3-dev libnl-route-3-dev

#include <iostream>
#include <fstream>
#include <string>
#include <cstring>
#include <lua5.3/lua.hpp>
#include <regex>
#include <vector>
#include <sys/utsname.h>
#include <sys/statvfs.h>
#include <sys/sysinfo.h>
#include <chrono>
#include <thread>

// #include <netlink/netlink.h>
// #include <netlink/genl/genl.h>
// #include <netlink/genl/ctrl.h>
// #include <linux/nl80211.h>
// #include <net/if.h>

using namespace std;

class fetchman
{
private:
    static string last_battery;
    static string last_battery_time;
    static map<string, string> cached_osinfo;
    static long long last_osinfo_update;
    static const long long CACHE_TIMEOUT = 10;

    static long long current_time()
    {
        return chrono::duration_cast<chrono::seconds>(chrono::system_clock::now().time_since_epoch()).count();
    }

public:
    // static vector<pair<string, string>> os_info()
    static int os_info(lua_State *L)
    {
        long long curr_time = current_time();
        if (cached_osinfo.empty() || curr_time - last_osinfo_update > CACHE_TIMEOUT)
        {
            vector<pair<string, string>> osinfo;
            ifstream file("/etc/os-release");
            regex prettyname("PRETTY_NAME=\"([^\"]+)\"");
            regex name("NAME=\"([^\"]+)\"");
            regex version("VERSION=\"([^\"]+)\"");
            regex version_id("VERSION_ID=\"([^\"]+)\"");
            regex id("ID=\"([^\"]+)\"");
            smatch matchstr;
            string line;
            osinfo.clear();

            while (getline(file, line))
            {
                if (regex_search(line, matchstr, prettyname))
                    osinfo.push_back({"prettyname", matchstr[1].str()});
                else if (regex_search(line, matchstr, name))
                    osinfo.push_back({"name", matchstr[1].str()});
                else if (regex_search(line, matchstr, version))
                    osinfo.push_back({"version", matchstr[1].str()});
                else if (regex_search(line, matchstr, version_id))
                    osinfo.push_back({"version_id", matchstr[1].str()});
                else if (regex_search(line, matchstr, id))
                    osinfo.push_back({"id", matchstr[1].str()});
            }
            cached_osinfo.clear();
            for (const auto &box : osinfo)
            {
                cached_osinfo[box.first] = box.second;
            }
            last_osinfo_update = curr_time;
        }
        lua_newtable(L);
        for (const auto &box : cached_osinfo)
        {
            lua_pushstring(L, box.first.c_str());
            lua_pushstring(L, box.second.c_str());
            lua_settable(L, -3);
        }
        return 1;
    }

    static int bat_info(lua_State *L)
    {
        const string bat_str = luaL_checkstring(L, 1);
        long long curr_time = current_time();
        if (last_battery_time.empty() || (curr_time - stoll(last_battery_time) > CACHE_TIMEOUT))
        {
            ifstream bat("/sys/class/power_supply/" + string(bat_str) + "/capacity");
            string battery;
            if (bat.is_open())
            {
                bat >> last_battery;
                bat.close();
                last_battery_time = to_string(curr_time);
            }
            else
            {
                last_battery = "N/A";
            }
        }

        lua_pushstring(L, last_battery.c_str());
        return 1;
    }

    static int bright_info(lua_State *L)
    {
        string bright_str = luaL_checkstring(L, 1);
        ifstream bright_level("/sys/class/backlight/" + bright_str + "/brightness");
        ifstream max_bright_level("/sys/class/backlight/" + bright_str + "/max_brightness");
        if (bright_level.is_open() && max_bright_level.is_open())
        {
            vector<pair<string, string>> result;
            string brightness_level, max_brightness_level;
            bright_level >> brightness_level;
            max_bright_level >> max_brightness_level;
            bright_level.close();
            max_bright_level.close();

            result.push_back({"brightness_level", brightness_level});
            result.push_back({"max_brightness", max_brightness_level});

            lua_newtable(L);
            for (const auto &box : result)
            {
                lua_pushstring(L, box.first.c_str());
                lua_pushstring(L, box.second.c_str());
                lua_settable(L, -3);
            }

            return 1;
        }
        else
        {
            lua_pushnil(L);
            return 1;
        }
    }
    static int mem_info(lua_State *L)
    {
        vector<pair<string, unsigned long>> meminfo;
        struct sysinfo sinfo;
        sysinfo(&sinfo);
        meminfo.push_back({"uptime", sinfo.uptime});
        meminfo.push_back({"totalram", sinfo.totalram});
        meminfo.push_back({"freeram", sinfo.freeram});
        meminfo.push_back({"sharedram", sinfo.sharedram});
        meminfo.push_back({"bufferram", sinfo.bufferram});
        meminfo.push_back({"totalswap", sinfo.totalswap});
        meminfo.push_back({"freeswap", sinfo.freeswap});
        meminfo.push_back({"totalhigh", sinfo.totalhigh});
        meminfo.push_back({"freehigh", sinfo.freehigh});

        lua_newtable(L);

        for (const auto &box : meminfo)
        {
            lua_pushstring(L, box.first.c_str());
            lua_pushnumber(L, static_cast<lua_Number>(box.second));
            lua_settable(L, -3);
        }
        return 1;
    }
    // static vector<pair<string, unsigned long>> storage_info(const string &path)
    static int storage_info(lua_State *L)
    {
        string path = luaL_checkstring(L, 1);
        vector<pair<string, unsigned long>> storage_info;
        struct statvfs statinfo;
        if (statvfs(path.c_str(), &statinfo) == 0)
        {
            storage_info.push_back({"block_size", statinfo.f_bsize});
            storage_info.push_back({"total_blocks", statinfo.f_blocks});
            storage_info.push_back({"free_blocks", statinfo.f_bfree});
            storage_info.push_back({"avail_blocks", statinfo.f_bavail});
            storage_info.push_back({"used_blocks", (statinfo.f_blocks - statinfo.f_bfree)});
            lua_newtable(L);
            for (const auto &box : storage_info)
            {
                lua_pushnumber(L, static_cast<lua_Number>(box.second));
                lua_pushstring(L, box.first.c_str());
                lua_settable(L, -3);
            }
        }
        else
        {
            storage_info.push_back({"unknown", 0});
            lua_newtable(L);
            for (const auto &box : storage_info)
            {
                lua_pushnumber(L, static_cast<lua_Number>(box.second));
                lua_pushstring(L, box.first.c_str());
                lua_settable(L, -3);
            }
        }
        return 1;
    }

    static int net_info(lua_State *L){}

};



string fetchman::last_battery = "";
string fetchman::last_battery_time = "";
map<string, string> fetchman::cached_osinfo;
long long fetchman::last_osinfo_update = 0;

extern "C" int luaopen_fetchman(lua_State *L)
{
    luaL_Reg functions[] = {
        {"os", fetchman::os_info},
        {"battery", fetchman::bat_info},
        {"brightness", fetchman::bright_info},
        {"mem", fetchman::mem_info},
        {"storage", fetchman::storage_info},
        {NULL, NULL}};

    luaL_newlib(L, functions);
    return 1;
}
