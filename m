Message-ID: <20051222223423.35638.qmail@web35609.mail.mud.yahoo.com>
Date: Thu, 22 Dec 2005 14:34:23 -0800 (PST)
From: Ady Deac <adydeac@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] htb accounting on bridge interface
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi!

I am using a linux bridge as an internet gateway. I have eth0 as the external interface, eth1 and
tap0 (OpenVPN) bridged together (br0). I was trying to make a seamless accounting for br0 with tc
and htb (hand made scripts). The accounting is not working for br0, instead I have to make
accounting on eth1 and tap0.
Is this the right way? I only want to limit the trafic between eth1 and eth0 + viceversa and tap0
and eth + viceversa.

Thanks in advance,
Ady Deac


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
