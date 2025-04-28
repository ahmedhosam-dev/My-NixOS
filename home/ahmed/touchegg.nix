{ pkgs, ... }:

{
  # Windows-like gesture configuration
  home.file.".config/touchegg/touchegg.conf".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <touchégg>
      <settings>
        <property name="animation_delay">100</property>
        <property name="action_execute_threshold">20</property>
      </settings>

      <application name="All">
        <!-- 3-finger swipe up = Task View (Win+Tab) -->
        <gesture type="SWIPE" fingers="3" direction="UP">
          <action type="SEND_KEYS">
            <repeat>false</repeat>
            <keys>Super+Tab</keys>
          </action>
        </gesture>

        <!-- 3-finger swipe down = Show Desktop (Win+D) -->
        <gesture type="SWIPE" fingers="3" direction="DOWN">
          <action type="SEND_KEYS">
            <repeat>false</repeat>
            <keys>Super+d</keys>
          </action>
        </gesture>

        <!-- 3-finger swipe left/right = Switch virtual desktops -->
        <gesture type="SWIPE" fingers="3" direction="LEFT">
          <action type="SEND_KEYS">
            <repeat>false</repeat>
            <modifiers>Control</modifiers>
            <keys>Super+Left</keys>
          </action>
        </gesture>
        <gesture type="SWIPE" fingers="3" direction="RIGHT">
          <action type="SEND_KEYS">
            <repeat>false</repeat>
            <modifiers>Control</modifiers>
            <keys>Super+Right</keys>
          </action>
        </gesture>

        <!-- 4-finger tap = Action Center (Win+A) -->
        <gesture type="TAP" fingers="4">
          <action type="SEND_KEYS">
            <repeat>false</repeat>
            <keys>Super+a</keys>
          </action>
        </gesture>
      </application>
    </touchégg>
  '';
}
