Message-ID: <eab08af20802221231w35d80434ie9bda84bafcd342c@mail.gmail.com>
Date: Fri, 22 Feb 2008 15:31:30 -0500
From: jieryn@gmail.com
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2163_15881995.1203712290450"
Subject: [Bridge] bridge-utils-1.4 unknown symbols
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_2163_15881995.1203712290450
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

I'm on a Gentoo vanilla-sources-2.6.24.2 kernel, with
bridge-utils-1.4installed. When I try to modprobe bridge dmesg shows:

Feb 22 15:22:51 indigo bridge: Unknown symbol br_handle_frame_hook
Feb 22 15:22:51 indigo bridge: Unknown symbol nf_register_hooks
Feb 22 15:22:51 indigo bridge: Unknown symbol br_fdb_put_hook
Feb 22 15:22:51 indigo bridge: Unknown symbol nf_unregister_hooks
Feb 22 15:22:51 indigo bridge: Unknown symbol nf_hook_slow
Feb 22 15:22:51 indigo bridge: Unknown symbol br_fdb_get_hook

indigo ~ # uname -a
Linux indigo 2.6.24.2 #2 SMP PREEMPT Tue Feb 19 13:48:26 EST 2008 i686
Intel(R) Core(TM)2 Duo CPU T7700 @ 2.40GHz GenuineIntel GNU/Linux

indigo ~ # modinfo bridge
filename:       /lib/modules/2.6.24.2/kernel/net/bridge/bridge.ko
version:        2.3
license:        GPL
srcversion:     917D0E52D3401B0EEDE6742
depends:        llc
vermagic:       2.6.24.2 SMP preempt mod_unload CORE2

indigo ~ # modinfo llc
filename:       /lib/modules/2.6.24.2/kernel/net/llc/llc.ko
description:    LLC IEEE 802.2 core support
author:         Procom 1997, Jay Schullist 2001, Arnaldo C. Melo 2001-2003
license:        GPL
depends:
vermagic:       2.6.24.2 SMP preempt mod_unload CORE2

Any help on this would be appreciated. Thanks! :-)
-jesse

-- 
There are 10 types of people in this world, those
that can read binary and those that can not.

------=_Part_2163_15881995.1203712290450
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,<br><br>I&#39;m on a Gentoo vanilla-sources-2.6.24.2 kernel, with bridge-utils-1.4 installed. When I try to modprobe bridge dmesg shows:<br><br>Feb 22 15:22:51 indigo bridge: Unknown symbol br_handle_frame_hook<br>
Feb 22 15:22:51 indigo bridge: Unknown symbol nf_register_hooks<br>Feb 22 15:22:51 indigo bridge: Unknown symbol br_fdb_put_hook<br>Feb 22 15:22:51 indigo bridge: Unknown symbol nf_unregister_hooks<br>Feb 22 15:22:51 indigo bridge: Unknown symbol nf_hook_slow<br>
Feb 22 15:22:51 indigo bridge: Unknown symbol br_fdb_get_hook<br><br>indigo ~ # uname -a<br>
Linux indigo <a href="http://2.6.24.2">2.6.24.2</a> #2 SMP PREEMPT Tue Feb 19 13:48:26 EST 2008 i686
Intel(R) Core(TM)2 Duo CPU T7700 @ 2.40GHz GenuineIntel GNU/Linux<br>
<br>indigo ~ # modinfo bridge<br>filename:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib/modules/2.6.24.2/kernel/net/bridge/bridge.ko<br>version:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.3<br>license:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GPL<br>srcversion:&nbsp;&nbsp;&nbsp;&nbsp; 917D0E52D3401B0EEDE6742<br>depends:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; llc<br>vermagic:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://2.6.24.2">2.6.24.2</a> SMP preempt mod_unload CORE2 <br>
<br>indigo ~ # modinfo llc<br>filename:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib/modules/2.6.24.2/kernel/net/llc/llc.ko<br>description:&nbsp;&nbsp;&nbsp; LLC IEEE 802.2 core support<br>author:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Procom 1997, Jay Schullist 2001, Arnaldo C. Melo 2001-2003<br>license:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GPL<br>
depends:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>vermagic:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://2.6.24.2">2.6.24.2</a> SMP preempt mod_unload CORE2 <br><br>Any help on this would be appreciated. Thanks! :-)<br>-jesse<br clear="all"><br>-- <br>There are 10 types of people in this world, those<br>
that can read binary and those that can not.

------=_Part_2163_15881995.1203712290450--
