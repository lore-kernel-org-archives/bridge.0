Message-ID: <43A83D07.4050402@phreaker.net>
Date: Wed, 21 Dec 2005 01:19:03 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
References: <439BDC54.30008@phreaker.net>
	<a3f524e0512160703o58250e54y69220c86e0498920@mail.gmail.com>
In-Reply-To: <a3f524e0512160703o58250e54y69220c86e0498920@mail.gmail.com>
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

My problem is solved...I didnt compiled the "Bridge: Netfilter 
Configuration"

And, iptables and ebtables works for me, :)


Kashif Ali Bukhari wrote:

>iptabels dont support bridge use ebtables ;)
>
>On 12/10/05, ro0ot <ro0ot@phreaker.net> wrote:
>  
>
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
>>    
>>
>
>
>--
>Syed Kashif Ali Bukhari
>Network Engineer
>Beaconhouse IT services, Lahore Pakistan
>
>
>  
>



