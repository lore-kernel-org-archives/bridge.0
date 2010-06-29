From: FAbrice <pixiesfr@gmail.com>
Date: Tue, 29 Jun 2010 19:29:54 +0300
References: <mailman.0.1277822116.26732.bridge@lists.linux-foundation.org>
In-Reply-To: <mailman.0.1277822116.26732.bridge@lists.linux-foundation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201006291929.55410.pixiesfr@gmail.com>
Subject: Re: [Bridge] Welcome to the "Bridge" mailing list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, b@iwatel.ro

Hi,
 
I have an issue with a bridged interface...
 
I use xenserver 5.5 on 2 serveur, both of this serveur are connected on 2 
different switch
both have the same configuration, this server are hosted and both have  4 ip 
assigned..
 
the server a ideticaly for the network card (r8169) , on one of this server , 
when i ping the main ip of the xenserver ( let say 10.0.0.1 ) no issue, if i 
ping an assigned ip (let say 10.0.0.2)  to this server wich is not present on 
the server,  
the main ip loose a packet for each packet sent on 10.0.0.2 , when i stop the 
ping of  10.0.0.2 , the ip 10.0.0.1 answer correctly..
 
no kernel message error, no error no where in the log...
 
if i manually enter a fake mac adress for the ip 10.0.0.2 on the server or if 
i enter the ip 10.0.0.2, no problem..
 
I have make a tcpdump, each icmp packet is replyed...
 
On the other server, which is connected to an another switch, but the same 
card, no pb at all...
 
If i remove the bridge , and let the ip on the eth0 no pb..( that whyi wrote 
here), as it's  linked to the bridge.
 
I try with a debian in rescue mode( different kernel), same issue...
 
I'm almost sure that it becomeing from the swith or the router, before, but my 
hoster still think that it becomeing from a misconfiguration of the server..
 
how can i debug the bridge ? to see waht happen when it bridged..
 
I'm a bit lost , i try to find on google ( google is my friend ;-) ), but i saw 
about ebtable, to log in the kernel, but i didnt find any error with this way..
 
If someone can help me..
 
Thank you
 
Fabrice 
 
 
