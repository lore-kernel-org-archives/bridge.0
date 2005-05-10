Message-ID: <4280068E.2070102@SiuLung.com>
Date: Tue, 10 May 2005 08:55:42 +0800
From: Alan Tam <Tam@SiuLung.com>
MIME-Version: 1.0
Subject: Re: [Bridge] How to disable verbose kernel logs for linux ethernet
	bridge?
References: <427D8B20.7010301@SiuLung.com>
	<20050509105253.293e60b9@dxpl.pdx.osdl.net>
In-Reply-To: <20050509105253.293e60b9@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Stephen Hemminger wrote:

>On Sun, 08 May 2005 11:44:32 +0800
>Alan Tam <Tam@SiuLung.com> wrote:
>  
>
>>This is part of my dmesg output which is generated whenever some network 
>>topology changes. It is very annoying. Any ways for me to inhibit those 
>>which are only informational but not warnings which I need to take care? 
>>I am running the all bridges on tap* interfaces emulated by OpenVPN. I 
>>am running stock 2.6.8 kernel from Debian sarge.
>>    
>>
>The easiest way would be to change all those printk's you don't want to see
>in the br_stp_if.c from:
>	printk(KERN_INFO "%s: port ...
>to
>	printk(KERN_DEBUG "%s: port ...
>
>then they will show up only in /var/log/messages.
>  
>
Yes, but recompiling the kernel is not a good thing to me. I think "echo 
5 > /proc/sys/kernel/printk" is acceptable. The reason it isn't the 
default is probably that most part of the kernel won't be so verbose.

-- 
Regards,
Alan

