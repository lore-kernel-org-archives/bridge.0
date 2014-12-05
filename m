Return-Path: <k1gto@comcast.net>
Date: Fri, 5 Dec 2014 17:16:56 +0000 (UTC)
From: k1gto@comcast.net
Message-ID: <958093748.14661359.1417799816972.JavaMail.zimbra@comcast.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14661358_813588771.1417799816971"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1417799817;
	bh=qJUmUI/U1vGaPQGgr/aPnk/E6NJFrZ9BDdylHrnY5eM=;
	h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
	Content-Type;
	b=XaX+XHSaQjbPeeGZv4WDu3GQoL64IXxFDFkm+SVSRHkRlmWJEWX4ARXEO7biP4O/0
	8L5lbYhoIaQe/WTlAblbKhWWyjHCtUhNctqHS88pqZUgiKvnTl0l8H127U+iK2+E4n
	iZH2HAQX8A7VjF+e9z+zrnyN07va8Tpz8TWP++ih9it89yutkPAxbJZ5WYeyEAM1SM
	RUol1DckYEt6stZor7woYCBviRRXWQs55IBRCVdAFHNeQv1Xb8Jii5ok4KjvDVFA/n
	EfpIn1ccVZ/IrHVHxa8OVrgrJzswgZCeLMcNKjf5azi3R1j3fkCuRTtTKsXJYp5yhg
	Q9QNrPre+HmIw==
Subject: [Bridge] IPv6 UDP responses not transmitting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_14661358_813588771.1417799816971
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Looking for suggestions for next steps -<br><br>My linux wifi access point =
"bluepi" has two physical interfaces - wifi and eth0. Those are joined in a=
 bridge called br0. br0 is auto-assigning itself two IPv6 "SLAAC" addresses=
 - one address is based on eth0 mac  and the other is based on wifi interfa=
ce mac. I find it odd that it assigns two - one of which does not correspon=
d to the MAC of br0. This is the address that has issues. <br><br>From anot=
her device on ethernet network I can ping6 both v6 addresses but SNMP queri=
es to one of the addresses fail to see a response. Tcpdump on the access po=
int shows that a response is "sent" but the response packet is not seen by =
the requestor. <br><br>Ipv6 SNMP requests originating from the *wifi* inter=
face to the device's br0 are successful against both SLAAC addresses. So pr=
oblem happens on ethernet side of the bridge. Perhaps flip flopping based o=
n order of interfaces being added to bridge. <br><br>I have Arpwatch runnin=
g on the same network and it tells me that bluepi  (interface br0) tends to=
 flip-flop it's mac when the device is rebooted sometimes. Not sure why.<br=
><br><br>What kernel component is responsible for the two v6 address assogn=
ments (as opposed to one)? I need to determine if this is a known issue or =
if I should report it somewhere (else). <br><br>Thanks<br><br><br>[Brad Hei=
n]
------=_Part_14661358_813588771.1417799816971--
