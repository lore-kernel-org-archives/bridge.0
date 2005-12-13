Message-ID: <439F12F7.2050407@phreaker.net>
Date: Wed, 14 Dec 2005 02:29:11 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridging Firewall with Kernel 2.6 failed
References: <439BDC54.30008@phreaker.net> <1134296796.611.66.camel@gadi>
In-Reply-To: <1134296796.611.66.camel@gadi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am using kernel 2.6.14.3, iptables 1.3.4 and bridge-utils 1.0.6

I did flag the "802.1d Ethernet Bridging" in Networking 
support/Networking options


Gladiston Justini - JustiSecure wrote:

> Mr. ro0ot,
>
>     You need:
>         1. Kernel 2.6.xx
>         2. Iptables 1.3.xx
>         3. brctl-util
>
> In kernel configuration, do you flag  '802.1d Ethernet Bridging' in  
> Network support/Networking options
>
>
> Sorry my english.
> :)
> Gadi
>
>
>
>
>
> On Sun, 2005-12-11 at 15:59 +0800, ro0ot wrote:
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
>>    
>>
>
>
>>
>>
>>_______________________________________________
>>Bridge mailing list
>>Bridge@lists.osdl.org <mailto:Bridge@lists.osdl.org>
>>https://lists.osdl.org/mailman/listinfo/bridge
>>    
>>



