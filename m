Date: Thu, 30 Jun 2005 08:15:53 -0400
From: Hugh Crissman <hcrissman@secure-mind.net>
Message-ID: <20050630121553.GA19988@secure-mind.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] bridge firewall
Reply-To: hcrissman@secure-mind.net
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am in the process of building a bridge firewall to place as the gateway to my network. I have a couple 
questions that I can't seem to find clear answers to. Can snort sniff on a bridged interface? Second, can 
ebtables block by IP? I know IP is layer 3 and a Bridge is Layer 2 but some of the recipes I have seen for 
ebtables have ips in them.

In general I would like to be able to snort all incoming traffic on the bridge and filter out any traffic from 
attackers who appear to be reoccurring offenders.

Thanks,

Hugh Crissman
