Message-ID: <45E91F1A.6050705@linux-foundation.org>
Date: Fri, 02 Mar 2007 23:09:14 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
MIME-Version: 1.0
References: <45E6802C.2090708@linux-foundation.org>	<20070228.233034.74746721.davem@davemloft.net>	<p733b4ncbui.fsf@bingen.suse.de>
	<20070302.202211.21926049.davem@davemloft.net>
In-Reply-To: <20070302.202211.21926049.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, greearb@candelatech.com, andi@firstfloor.org, bridge@linux-foundation.org

David Miller wrote:
> From: Andi Kleen <andi@firstfloor.org>
> Date: 03 Mar 2007 03:14:29 +0100
>
>   
>> That's pretty common with many x86 server boards because 
>> they come with two NICs by default but must people only
>> plug the cable into one. However the distro installers
>> run DHCP on all.
>>     
>
> Nope, that's not what I've seen them do, instead they run dhcp on
> interfaces that report a link being present.
>   

Actually, It may be even simpler... I start bridge with a script and 
there was still a dhclient
left over running on the original interface.  It was an interesting 
exercise, and I have new
tools to help, but still no magic bullet to get up to full line rate.
