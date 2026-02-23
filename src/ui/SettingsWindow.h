#pragma once
#include <windows.h>
#include <string>
#include <vector>

namespace ClipboardPush {
namespace UI {

class SettingsWindow {
public:
    static SettingsWindow& Instance();

    bool Create(HINSTANCE hInstance, HWND hParent);
    void Show(bool show = true);
    void SetUpdateAvailable(const std::string& version, const std::string& url);
    HWND GetHWND() const { return m_hWnd; }

private:
    SettingsWindow() = default;
    static INT_PTR CALLBACK DialogProc(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam);
    
    void LoadSettings();
    void SaveSettings();
    void UpdateQR(const std::string& content);

    HWND m_hWnd = NULL;
    HWND m_hParent = NULL;
    std::vector<bool> m_qrModules;
    int m_qrSize = 0;
    std::string m_updateUrl;
    std::string m_newVersion;
};

}
}
