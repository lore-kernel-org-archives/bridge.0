Message-ID: <439F1372.4060103@phreaker.net>
Date: Wed, 14 Dec 2005 02:31:14 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
References: <57F9959B46E0FA4D8BA88AEDFBE582900B59D2@pxtbenexd01.pxt.primeexalia.com>
In-Reply-To: <57F9959B46E0FA4D8BA88AEDFBE582900B59D2@pxtbenexd01.pxt.primeexalia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Bridging Firewall with Kernel 2.6 failed
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi Gary,

All the commands I ran did not show any failing messages.

The traffic doesn't seems passing through the bridge, why?

Do I need "physdev" in iptables to get bridging firewall work?


Gary W. Smith wrote:

>Hi ro0ot, 
>
>Exactly what part of "doesn't work anymore" doesn't work?  Does it not
>work when you create the bridge or does it not work after you apply
>iptables?  What commands are you running to instantiate the bridge?
>What commands do you think are failing?
>
>Gary Wayne Smith
>
>  
>
>>-----Original Message-----
>>From: netfilter-bounces@lists.netfilter.org [mailto:netfilter-
>>bounces@lists.netfilter.org] On Behalf Of ro0ot
>>Sent: Saturday, December 10, 2005 11:59 PM
>>To: netfilter@lists.netfilter.org; bridge@lists.osdl.org
>>Subject: Bridging Firewall with Kernel 2.6 failed
>>
>>Hi all,
>>
>>I have a bridging firewall running fine with kernel 2.4.31 (Slackware
>>10.1) and iptables 1.2.11
>>
>>Yesterday I install the new kernel 2.6.14.3 and iptables 1.3.4 but the
>>bridging firewall doesn't work anymore.
>>
>>Do I need to patch the kernel 2.6 as what I did it for kernel 2.4? Or
>>what I have missed?
>>
>>Regards,
>>ro0ot
>>
>>
>>
>>    
>>
>
>
>
>
>  
>



