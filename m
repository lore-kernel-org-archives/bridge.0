Message-ID: <42A8058C.2060408@ya.com>
Date: Thu, 09 Jun 2005 11:02:04 +0200
From: =?ISO-8859-1?Q?Guillermo_Ib=E1=F1ez?= <gibanezfer@ya.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Multicast
References: <03b001c56bfd$cd346c70$825810ac@amon>
	<20050608093152.32e3c9c5@unknown-215.office.pdx.osdl.net>
In-Reply-To: <20050608093152.32e3c9c5@unknown-215.office.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Just an explanation to distinguish processing of layer 3 multicast 
packets (by routers) from layer 2 multicast frames (by bridges).  Due to 
the fact that the multicast MAC addresses are not permitted in the 
Ethernet frame as source addresses, multicast MAC addresses can not be 
learnt by the bridges, so the processing of multicast addresses by 
bridges consists in broadcasting, flooding frames in all but source 
port, instead of forwarding them only by ports where these addresses 
were learnt.
Excuse me if it sounds a bit "academic".
GI

Stephen Hemminger wrote:

>On Wed, 8 Jun 2005 09:43:46 +0200
>"Tomo Ceferin" <tomo@activetools.si> wrote:
>
>  
>
>>Hi,
>>
>>I checked archives but I haven't found this subject before.
>>
>>Does bridge support multicast or not? I checked the code and it would seem
>>that bridge will flood multicast frames to all but source port.
>>
>>Rgds, Tomo Ceferin
>>Active Tools
>>    
>>
>
>Yes, that is what multicast is.
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Bridge mailing list
>Bridge@lists.osdl.org
>http://lists.osdl.org/mailman/listinfo/bridge
>  
>
