From: monade@freenet.de
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1085305521-13101-268"
Message-Id: <E1BRpXa-0002dM-L9@www9.emo.freenet-rz.de>
Date: Sun, 23 May 2004 11:45:10 +0200
Subject: [Bridge] ebtables rules dont work
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------------=_1085305521-13101-268
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,<br>
i have some problems with testing the ebtables on my machine.<br>
It's a Vanilla Kernel 2.6.5 and I selected:<br>
<br>
- [*] 802.1d Ethernet Bridging<br>
- Netfilter iptables option  <br>
<br>
and all ebtables options to compile new for a bridge machine.<br>
This works sucesfully and i installed ebtables v2.0.6.<br>
<br>
Now my Problem is that all packets will be Droped in the Forward Chain.<br>
It makes the appearance that it's unimportant wich rule i use.<br>
<br>
Here my very simple rule Setup only for testing:<br>
ebtables -P FORWARD DROP<br>
ebtables -P INPUT DROP<br>
ebtables -P OUTPUT DROP<br>
ebtables -A FORWARD -p IPv4 --ip-proto tcp --ip-sport 80 -j ACCEPT <br>
<br>
When i use iptables for filtering i can/must see the same effect. <br>
<br>
What I'have done wrong ? forgot options in the kernel, forgot rules ?<br>
<br>
<br>
greets


<br>--<br><!-- AdSpace freenet EMO Webmail Banner -->=20
<a href=3D"http://adserver.freenet.de/click.ng/site=3Dfn&prod=3Dchetools&ka=
t=3Drub&tbl=3Dwebmail&ppos=3D1&TransactionID=3D1085305510568287&rgtg=3D256"=
 target=3D"_blank"><img DEFANGED_src=3D"http://adserver.freenet.de/image.ng=
/site=3Dfn&prod=3Dchetools&kat=3Drub&tbl=3Dwebmail&ppos=3D1&TransactionID=
=3D1085305510568287&rgtg=3D256" border=3D0></a><!-- / AdSpace -->


------------=_1085305521-13101-268
Content-Type: text/plain; name="SpamAssassinReport.txt"
Content-Disposition: inline; filename="SpamAssassinReport.txt"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

Spam detection software, running on the system "fire-2.osdl.org", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or block
similar future email.  If you have any questions, see
the administrator of that system for details.

Content preview:  Hello, i have some problems with testing the ebtables
  on my machine. It's a Vanilla Kernel 2.6.5 and I selected: - [*] 802.1d
  Ethernet Bridging - Netfilter iptables option and all ebtables options
  to compile new for a bridge machine. This works sucesfully and i
  installed ebtables v2.0.6. [...] 

Content analysis details:   (6.4 points, 5.0 required)

 pts rule name              description
---- ---------------------- --------------------------------------------------
 1.1 NO_REAL_NAME           From: does not include a real name
 0.8 HTML_30_40             BODY: Message is 30% to 40% HTML
 0.2 HTML_MESSAGE           BODY: HTML included in message
 0.5 HTML_IMAGE_ONLY_08     BODY: HTML: images with 600-800 bytes of words
 2.0 MIME_HTML_ONLY         BODY: Message only has text/html MIME parts
 1.1 HTML_MIME_NO_HTML_TAG  HTML-only message, but there is no HTML tag
 0.7 PRIORITY_NO_NAME       Message has priority setting, but no X-Mailer



------------=_1085305521-13101-268--
