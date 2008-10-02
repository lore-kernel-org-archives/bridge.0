Message-ID: <48E4C5A6.5060307@navigue.com>
Date: Thu, 02 Oct 2008 08:59:18 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <BAY143-W259AA8EA71D7D77498511CA63D0@phx.gbl>
In-Reply-To: <BAY143-W259AA8EA71D7D77498511CA63D0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] route few users to another server ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "SYED JAHANZAiB ~!~ AA Internet Cable.Network Services" <aacable@hotmail.com>
Cc: bridge@lists.linux-foundation.org

Is there a reason why you don't do this through NAT at the 10.0.0.1 
machine?  It sounds to me like it would be a bit more conventional.  I'm 
not sure why you would get requests for 10.0.0.0/8 IPs from the internet.

Jonathan

SYED JAHANZAiB ~!~ AA Internet Cable.Network Services wrote:
> users   ====>      Bridge    =====> PROXY IP: 10.0.0.1
>  
> My local LAN using these ip series
> 10.0.0.x
> 10.0.1.x
> 10.0.2.x
> Now I want that all internet request for specific 20-30 ip's should 
> redirect to another pc e.g
> 10.0.0.10
> 10.0.0.15
> 10.0.1.50
> 10.0.2.70 . . . .
> to another server on my LAN let's 10.0.0.2.
> How to do this ???
>
>
>  
>  
> *Regards, *
> *SYED JAHANZAIB*
> ** 
> AA iNTERNET CABLE.NETWORK SERViCES
> Web   :  http://www.aacablenet.org <http://www.aacablenet.org/>
> Email  :  aacable@hotmail.com [MSN Messenger]
> Mobile : 0333-3021909
>
> ------------------------------------------------------------------------
> Connect to the next generation of MSN Messenger  Get it now! 
> <http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline> 
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

