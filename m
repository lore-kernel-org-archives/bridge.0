Message-ID: <410BA02F.9080901@maxent.cz>
Date: Sat, 31 Jul 2004 15:35:43 +0200
From: Karel Rericha <karel@maxent.cz>
MIME-Version: 1.0
Subject: Re: [Bridge] Re: Bridge for linux
References: <200407302227.43830.xavier@xaviervl.com>
	<20040730171222.54cfe8df@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040730171222.54cfe8df@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Stephen Hemminger napsal(a):

>On Fri, 30 Jul 2004 22:27:43 +0200
>Xavier Van Laethem <xavier@xaviervl.com> wrote:
>
>  
>
>>>From FAQ
>>------------------------------------------------------
>>It doesn't work with my Wireless card!
>>
>>This is a known problem, and it is not caused by the bridge code. Many 
>>wireless cards don't allow spoofing of the source address. It is a firmware 
>>restriction with some chipsets. You might find some information in the bridge 
>>mailing list archives to help.
>>------------------------------------------------------
>>
>>Trying with hostap driver for wifi card. It work when wifi card is in master 
>>mode but it is no more working with wifi card in managed or ad-hoc mode. 
>>So y try changing hardfware (ethernet) address of the wireless card (using the 
>>one of bridge interface) with "ip link set wlan0 address..."  and it seems to 
>>work well... (it should also work with "ifconfig..." but  y an using the one  
>>comming from busybox and it doesn't allow to change hw address)
>>y dont find any such solution in the mailing list....
>>    
>>
>
>It seems that hostap doesn't provide the same interface as normal ethernet card.
>One problem is that it doesn't forward packets between nodes connected to the
>same access point.  These are hostap problems, and should be fixed there, the bridge
>code shouldn't need to have special code for the hostap devices.
>  
>
Hostap in master mode does forward packets between stations connected to 
the same access point. This is
default behaviour. But alas, not always welcome (read "traffic 
shaping"). It can be switched of by
iwpriv wlan0 bridge_packets 0
but after that no packets sourced from wlan0 arrive back to wlan0 if 
this is bridged interface. Bridge code
doesn't allow this, even if these packets are destined to stations 
connected to hostap. Stephen some time
ago suggested implementing "layered" hostap driver to overcome this, but 
I don't know what does it mean.

>  
>
>>By the way, why is the hardware address of the bridge chanching at each 
>>interface added to the bridge? Solution would be simpler if the bridge keep 
>>hardware addres of the first interface added, and by adding wireless 
>>interface first, no?
>>    
>>
>
>Probably just a stupid day one coding bug..  The problem is what if the 
>first interface goes away?
>
>
>  
>
>>Xavier Van Laethem
>>    
>>
>>------------------------------------------------------------------------
>>
>>_______________________________________________
>>Bridge mailing list
>>Bridge@lists.osdl.org
>>http://lists.osdl.org/mailman/listinfo/bridge
>>    
>>


