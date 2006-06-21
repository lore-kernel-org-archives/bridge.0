Message-ID: <44997DC7.60605@kingsley.co.za>
Date: Wed, 21 Jun 2006 19:11:35 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge and transparent squid proxy
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello Paul,

I am also newly registered. I do think that I have the above subject covered, but I might be mistaken. I have 2 bridge instances (br0 and br1) - 
external link and internal link respectively. Here are the rules I used in my Debian Sarge machine - 

IPT="/sbin/iptables"
EBT="/sbin/ebtables"

EXTIF="br1"

# Firewall start, the basics....
# __________________________________________________________

# Lets Lockdown this machine and then open up the required services

$EBT -A FORWARD -p IPv4 -j ACCEPT
$EBT -A FORWARD -p ARP -j ACCEPT
$EBT -A INPUT -p IPv4 -j ACCEPT
$EBT -A INPUT -p ARP -j ACCEPT
$EBT -A OUTPUT -p IPv4 -j ACCEPT
$EBT -A OUTPUT -p ARP -j ACCEPT

-------<cut>-----

$EBT -t broute -A BROUTING -p IPv4 --ip-protocol 6 --ip-destination-port 80      -j redirect --redirect-target          ACCEPT
$IPT -t nat -A PREROUTING -p tcp --dport 3128                                                      			-j DROP
$IPT -t nat -A PREROUTING -p tcp --dport www -m iprange --src-range $INTNWRANGE                                    	-j REDIRECT --to-port 3128
$IPT -A INPUT  -p tcp -i ${EXTIF%[0-9]}+ --dport 3128                            -m state --state NEW,ESTABLISHED       -j ACCEPT
$IPT -A OUTPUT -p tcp -o ${EXTIF%[0-9]}+ --sport 3128                            -m state --state ESTABLISHED           -j ACCEPT

Two additional things that I would like to point out... I did add IP addresses to both of my brX's but in your case try add an IP address to your br0.
It seems that when you run services on the machine with bridging on the device you are going through that you need to give an IP address on that device
otherwise it just plainly doesn't work - well I didn't get it right anyway. I am doing the same for SMTP and FTP and it seems to work fine. I was hoping,
after my other post, to ask an aditional question about the having only an IP address on my WAN side and service my LAN through the internal bridge with
proxy-arp on... so that I can set the gateway of my LAN to the WAN address or a machine another hop beyound it.


-- 
Kind Regards
Etienne


