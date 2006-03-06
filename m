From: Eriberto <eriberto@eriberto.pro.br>
Date: Mon, 06 Mar 2006 13:45:17 -0300
Message-ID: <duhp0q$ca0$4@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: news <news@sea.gmane.org>
Subject: [Bridge] IPS HLBR 1.0 released (off-topic)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

IPS HLBR - Version 1.0 can detect malicious traffic using regular
expressions

Version 1.0 of Hogwash Light BR, released march 5th 2006, brings two
interesting new features. The first one is the ability of using
regular expressions to detect intrusion attempts and e-mails with
virus or phishing. The second is the use of lists with banned words.

HLBR is an IPS (Intrusion Prevention System) that reads network
traffic in the layer 2 of the OSI model. Since it works like a bridge,
it stays in-line in the network topology and doesn't need an IP
address. So, HLBR is invisible to attackers. Traffic filtering
(including the packets contents) can be done with simple rules.
Version 1.0 can use regular expressions to filter the packets. Below
is an example of rule with regular expressions (please, ignore underIPS=20
HLBR - Version 1.0 can detect malicious traffic using regular
expressions

Version 1.0 of Hogwash Light BR, released march 5th 2006, brings two
interesting new features. The first one is the ability of using
regular expressions to detect intrusion attempts and e-mails with
virus or phishing. The second is the use of lists with banned words.

HLBR is an IPS (Intrusion Prevention System) that reads network
traffic in the layer 2 of the OSI model. Since it works like a bridge,
it stays in-line in the network topology and doesn't need an IP
address. So, HLBR is invisible to attackers. Traffic filtering
(including the packets contents) can be done with simple rules.
Version 1.0 can use regular expressions to filter the packets. Below
is an example of rule with regular expressions:

<rule>
ip dst(email)
tcp dst(25)
tcp regex(filename=3D"[^\n]+\.scr")
message=3D(mailvirus-1-re) .scr attach
action=3Dvirus
</rule>

In short, all TCP traffic destined to port 25 of the e-mail server
will be filtered. If the text:

filename=3D"anything_different_of_line_breaks.scr"

is found inside the packet, that means there are an attachment .scr in
the e-mail (virus). So this packet will suffer the action named 'virus'.
This action logs the event, dumps the malicious traffic in tcpdump
format and drops the packet. Below is an example of rule against a type
of buffer overflow attempt against DNS servers:

<rule>
ip dst(dns)
udp dst(53)
udp nocase(|41cd 80c7 062f 6269 6ec7 4604 2f73 6800  89f0 83c0 0889 4608|)
message=3D(dnsattacks-1) tsl bind attack
action=3Daction1
</rule>

In this case, due to the use of pipe characters (|), HLBR will check
the traffic for the hexadecimal sequence given as an attack signature.

HLBR lets you use rules for blocking attacks against network servers.
In order to fully understand it please read our documentation at
http://hlbr.sourceforge.net/ips-en.html - explanations about the IPS
concept including charts.

HLBR site is at http://hlbr.sourceforge.net.

(Translated from Portuguese by Andr=E9 Bertelli - andre (a) bertelli.name)

lines in s_c_r):

<rule>
ip dst(email)
tcp dst(25)
tcp regex(filename=3D"[^\n]+\.s_c_r")
message=3D(mailvirus-1-re) .s_c_r attach
action=3Dvirus
</rule>

In short, all TCP traffic destined to port 25 of the e-mail server
will be filtered. If the text:

filename=3D"anything_different_of_line_breaks.s_c_r"

is found inside the packet, that means there are an attachment .scr in
the e-mail (virus). So this packet will suffer the action named 'virus'.
This action logs the event, dumps the malicious traffic in tcpdump
format and drops the packet. Below is an example of rule against a type
of buffer overflow attempt against DNS servers:

<rule>
ip dst(dns)
udp dst(53)
udp nocase(|41cd 80c7 062f 6269 6ec7 4604 2f73 6800  89f0 83c0 0889 4608|)
message=3D(dnsattacks-1) tsl bind attack
action=3Daction1
</rule>

In this case, due to the use of pipe characters (|), HLBR will check
the traffic for the hexadecimal sequence given as an attack signature.

HLBR lets you use rules for blocking attacks against network servers.
In order to fully understand it please read our documentation at
http://hlbr.sourceforge.net/ips-en.html - explanations about the IPS
concept including charts.

HLBR site is at http://hlbr.sourceforge.net.

(Translated from Portuguese by Andr=E9 Bertelli - andre (a) bertelli.name)

