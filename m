Message-ID: <42EA5CBC.5060805@metaloft.com>
Date: Fri, 29 Jul 2005 09:43:40 -0700
From: Dirk Morris <dmorris@metaloft.com>
MIME-Version: 1.0
Subject: Re: [Bridge] mac table updates
References: <42E968FF.6000607@metaloft.com>
	<20050728213302.18c9fd06@localhost.localdomain>
In-Reply-To: <20050728213302.18c9fd06@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

>
>
>>I think the new mac ageing (sometime since 2.6.8.1) may be too
>>aggressive. Now it updates the table at a much later time, with a
>>comment in the code that leads me to believe
>>this is to prevent counting spoofed packets and a DOS.
>>
>>My problem is that the update occurs after the netfilter hooks which
>>may do weird things to change the course of the packet so that it
>>does not get counted.
>>(in my case, redirecting, queueing to userspace, nonlocally bound 
>>sockets, etc).
>>For me this causes packets to go spewing out on the wrong interface
>>when the timer expires.
>>
>>I used the attached patch to revert back to the old method.
>>    
>>
>If you are whacking the source address, that seems wrong.  The fix for
>that would be to copy the original source address somewhere, then
>extract it back afterwards.
>  
>
I think I was leaving the source address, but I was queueing to 
userspace, which causes the packet
to "disappear" from the kernel, meaning the update code was just never 
reached.

