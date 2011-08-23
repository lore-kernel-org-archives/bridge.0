Message-ID: <4E5353E0.4010507@sfc.wide.ad.jp>
Date: Tue, 23 Aug 2011 16:16:48 +0900
From: Ang Way Chuang <wcang@sfc.wide.ad.jp>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------070602050900090700060504"
Subject: [Bridge] IPv6 multicast snooping behaviour on 2.6.39-rc2 and later
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Linus_L=FCssing?= <linus.luessing@web.de>, yoshfuji@linux-ipv6.org, Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------070602050900090700060504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

    I have a testbed setup on my VM environment that needs to use MLDv2 report message. My PIM router which is connected to a port on the bridge relies upon MLDv2 message to work. However, the setup failed to work after 2.6.39-rc2 or later. MLDv2 won't be forwarded to any slave ports bound to the bridge interface. Specifically, I track the cause down to this commit id:
  ff9a57a62afbbe2d0f3a09af321f1fd7645f38a5
    However, as soon as I disable multicast snooping on sysfs, MLDv2 message can be forwarded again.

    I am not knowledgeable on the subject of multicast snooping, but is this right behaviour for multicast snooping? IPv4 doesn't seem to suffer the same fate though, IGMP can be forwarded even if multicast_snooping is enabled. Thank you in advance.


Regards,
Ang Way Chuang



--------------070602050900090700060504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
    <link href="chrome://translator/skin/floatingPanel.css"
      type="text/css" rel="stylesheet">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <tt>Hi all,<br>
      <br>
      &nbsp;&nbsp; I have a testbed setup on my VM environment that needs to use
      MLDv2 report message. My PIM router which is connected to a port
      on the bridge relies upon MLDv2 message to work. However, the
      setup failed to work after 2.6.39-rc2 or later. MLDv2 won't be
      forwarded to any slave ports bound to the bridge interface.
      Specifically, I track the cause down to this commit id:<br>
    </tt><tt>&nbsp;ff9a57a62afbbe2d0f3a09af321f1fd7645f38a5<br>
      &nbsp;&nbsp; However, as soon as I disable multicast snooping on sysfs,
      MLDv2 message can be forwarded again. </tt><tt><br>
      <br>
      &nbsp;&nbsp; I am not knowledgeable on the subject of multicast snooping,
      but </tt><tt>is this right behaviour for multicast snooping? IPv4
      doesn't seem to suffer the same fate though, IGMP can be forwarded
      even if multicast_snooping is enabled. Thank you in advance.<br>
      <br>
      <br>
      Regards,<br>
      Ang Way Chuang<br>
      <br>
      <br>
    </tt>
    <div style="bottom: auto; left: 1015px; right: auto; top: 109px;
      display: none;" class="translator-theme-default"
      id="translator-floating-panel">
      <div title="Click to translate"
        id="translator-floating-panel-button"></div>
    </div>
  </body>
</html>

--------------070602050900090700060504--
