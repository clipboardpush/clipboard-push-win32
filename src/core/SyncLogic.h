#pragma once
#include <string>
#include "ui/NotificationWindow.h"

namespace ClipboardPush {
    bool PushText(const std::string& text);
    void ShowNotification(const std::wstring& title, const std::wstring& message, UI::NotificationStyle style = UI::NotificationStyle::Inbound);
    void ProcessReceivedFile(const std::string& filePath, const std::string& filename, const std::string& type);
}
