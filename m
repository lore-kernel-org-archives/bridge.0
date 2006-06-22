Message-ID: <449A4B0E.1070705@kingsley.co.za>
Date: Thu, 22 Jun 2006 09:47:26 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Newbie at work - need some advise/guidence please.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Just so that I might complete my own post,

It seems that with my slave firewall that ebtables was set up to drop 
all non ARP and IPv4 packets -
this was intended, but to my surprise it also blocked all STPBPDU 
packets. I am unable to figure out
a rule to allow those packets through - but the setup is working thus far.

Jun 22 09:14:51 geminus kernel: EBFW-INPUT IN=eth0 OUT= MAC source = 
00:10:b5:4b:f5:ea MAC dest = 01:80:c2:00:00:00 proto = 0x0026
Jun 22 09:14:51 geminus kernel: EBFW-INPUT IN=eth3 OUT= MAC source = 
00:0d:88:53:48:c5 MAC dest = 01:80:c2:00:00:00 proto = 0x0026
Jun 22 09:14:52 geminus kernel: EBFW-OUTPUT IN= OUT=eth6 MAC source = 
00:0d:88:68:7d:2f MAC dest = 01:80:c2:00:00:00 proto = 0x0026
Jun 22 09:14:52 geminus kernel: EBFW-OUTPUT IN= OUT=eth5 MAC source = 
00:0d:88:68:7d:2e MAC dest = 01:80:c2:00:00:00 proto = 0x0026
Jun 22 09:14:52 geminus kernel: EBFW-OUTPUT IN= OUT=eth4 MAC source = 
00:0d:88:68:7d:2d MAC dest = 01:80:c2:00:00:00 proto = 0x0026
Jun 22 09:14:52 geminus kernel: EBFW-OUTPUT IN= OUT=eth3 MAC source = 
00:0d:88:68:7d:2c MAC dest = 01:80:c2:00:00:00 proto = 0x0026

I would like to know if anyone has been able to allow only ARP,IPv4 and 
STPBPDU (proto = 0x0026) packets through by means of ebtables rules,
ie can someone give me a push in the right direction in making a rule to 
allow STPBPDU (proto = 0x0026) packet through?

Kind Regards
Etienne

