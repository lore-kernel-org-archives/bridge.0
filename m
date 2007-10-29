Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Small packets
Date: Mon, 29 Oct 2007 16:40:42 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D06@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

 

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org] 
Sent: Monday, 29 October 2007 4:12 PM
To: Leigh Sharpe
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Small packets

On Mon, 29 Oct 2007 15:37:52 +1100
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

>> Which seems to bridge OK. However, I have noticed that the bridge
>> appears to be truncating some packets. In particular, I am worried
>> about packets such as IP ACK's, which are entering the bridge as
>> 64-byte packets, but coming out the other side as 60-byte packets.
>> As I recall, the smallest valid ehternet packet is 64 bytes. The
>> bridge seems to be removing any padding in the packet and sending it
>> on it's way as a packet smaller than the minimum ethernet packet
>> size. Looking at the packet distribution on other devices connected
>> to the bridge, it seems to be doing the same to lots of other
> packets, too. Anybody got any idea why the bridge might be truncating
> packets? Any idea why it's sending 60-byte packets, when the minimu
> should be 64? Or where to tell it to pad all packets out to 64 bytes?
>  
>  
> Leigh.
>  

>What hardware? It could be a driver bug.
>Also if you use VLAN's then the driver may send 60 byte packet (because
>of the 4 byte VLAN tag).

Standard e1000 hardware.
The packets being bridged contain a VLAN tag, which is included in the
60 bytes.




