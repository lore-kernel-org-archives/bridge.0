Message-ID: <4A3A758C.8050807@gmail.com>
Date: Thu, 18 Jun 2009 19:12:44 +0200
From: Hamza Ferrag <hferraggreat@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Problem with DHCP Requests Forward in Bridge
Reply-To: hferraggreat@gmail.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi All,

My requirement is as below,

- I have de create a bridge on linux machine (kernel 2.6) and i have 2 
physical interfaces (eth0 & eth2)
- I have a scheme like this


Windows                                                                       

DHCP                                                                            
DHCP
Client                     Linux 
Bridge                                         Server
 -------                  
-----------------                                    ----------
|  eth0 |----------------| eth1        
eth0|--------------------10.255.0.1/24-| eth0     |
| (dhcp)|                | (br0=eth0+eth1) 
|                                  |          |
 -------                  
-----------------                                    ----------


First Scenario :

Fixed ip adresse of br0 in my Linux Bridge (192.168.0.1)

Results :
  * Windows Client obtain an ip adress from dhcp server (10.255.0.2) 
(dhcp requests pass correctelly throught Linux Bridge).
  *And i can manage my Linux Bridge from a Windows PC (using 
http://192.168.0.1). All is good and this is my goal.

Second Scenario :

I switch the br0 to dhcp (not fixed IP)

Results :
  * My Linux bridge obtain an ip adress (br0=10.255.0.3)..all right
  * But, i can't access anywher from my Windows client (i can't obtain 
an ip)
  * A tcpdump on my Linux Bridge, i see DHCP REQUEST arrived from 
Windows PC on eth1 interface but not repeated on eth0 interface..:(.



MY goal is that the Windows can obtain an IP from the dhcp server, and i 
will able to administer my Linux Bridge (a simple box-router that a 
developed myself).

Thanks a lot for your help.

Hamza F
