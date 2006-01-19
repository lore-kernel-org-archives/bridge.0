Message-ID: <4bbd421b0601191250o47dba515h64b961a80c658fd4@mail.gmail.com>
Date: Thu, 19 Jan 2006 14:50:11 -0600
From: Jason Alpers <jasealpers@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1243_745362.1137703811311"
Subject: [Bridge] Source IP Modified on Broadcast Packet Through Bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

------=_Part_1243_745362.1137703811311
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am encountering a problem where the source address on broadcast packets
seems to be altered to the local IP by the bridge netfilter.  The details on
the issue are documented here
http://forums.gentoo.org/viewtopic-t-420158-highlight-.html.  As a
workaround to this issue, I have disabled the bridge netfilter through the
proc filesystem with:

echo "0" > /proc/sys/net/bridge/bridge-nf-call-iptables

This workaround stops the source address of the broadcast packets from being
altered.  However, it also precludes a firewall on the bridge adapter.
Based on http://lists.osdl.org/pipermail/bridge/2005-January/000804.html, it
seems that another workaround is to remove the iptable_nat module.

Has this been identified as a bug?

As I'm not subscribed to the list, please cc me on response.

Thanks again,

--Jase

------=_Part_1243_745362.1137703811311
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I am encountering a problem where the source address on broadcast pack=
ets seems to be altered&nbsp;to the&nbsp;local IP&nbsp;by the bridge netfil=
ter.&nbsp; The details on the issue are documented here <a href=3D"http://f=
orums.gentoo.org/viewtopic-t-420158-highlight-.html">
http://forums.gentoo.org/viewtopic-t-420158-highlight-.html</a>.&nbsp; As a=
 workaround to this issue, I have disabled the bridge netfilter through the=
 proc filesystem with:</div>
<div>&nbsp;</div>
<div>echo &quot;0&quot; &gt; /proc/sys/net/bridge/bridge-nf-call-iptables</=
div>
<div>&nbsp;</div>
<div>This workaround&nbsp;stops the source address of&nbsp;the broadcast pa=
ckets from being altered.&nbsp; However, it also precludes a firewall on th=
e bridge adapter.&nbsp; Based on <a href=3D"http://lists.osdl.org/pipermail=
/bridge/2005-January/000804.html">
http://lists.osdl.org/pipermail/bridge/2005-January/000804.html</a>, it see=
ms that another workaround is to remove the iptable_nat module.</div>
<div>&nbsp;</div>
<div>Has this been identified as a bug?</div>
<div>&nbsp;</div>
<div>As I'm not subscribed to the list,&nbsp;please cc me on response.</div>
<div>&nbsp;</div>
<div>Thanks again,</div>
<div>&nbsp;</div>
<div>--Jase</div>

------=_Part_1243_745362.1137703811311--
