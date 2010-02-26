Message-ID: <4B883A27.9040803@parallels.com>
Date: Sat, 27 Feb 2010 00:16:23 +0300
From: Pavel Emelyanov <xemul@parallels.com>
MIME-Version: 1.0
References: <20100226165104.GB5364@lenovo>	<4B88076F.8030302@openvz.org>	<20100226100102.0d52c6e9@nehalam>	<20100226.100800.116618587.davem@davemloft.net>	<20100226103003.097c39ec@nehalam>	<4B8815AE.1090909@candelatech.com>
	<20100226104946.4168e378@nehalam>
In-Reply-To: <20100226104946.4168e378@nehalam>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@linux-foundation.org, netdev@vger.kernel.org, gorcunov@gmail.com, den@openvz.org, Ben Greear <greearb@candelatech.com>, David Miller <davem@davemloft.net>

Stephen Hemminger wrote:
> On Fri, 26 Feb 2010 10:40:46 -0800
> Ben Greear <greearb@candelatech.com> wrote:
> 
>> On 02/26/2010 10:30 AM, Stephen Hemminger wrote:
>>> On Fri, 26 Feb 2010 10:08:00 -0800 (PST)
>>> David Miller<davem@davemloft.net>  wrote:
>>>
>>>> From: Stephen Hemminger<shemminger@linux-foundation.org>
>>>> Date: Fri, 26 Feb 2010 10:01:02 -0800
>>>>
>>>>> TCP connections are never really bound to device. TCP routing is
>>>>> flexible; if packets can get through, it doesn't care.
>>>> I think he might be talking about SO_BINDTODEVICE
>>> What application does that with TCP?
>> I use it..helps with using multiple interfaces on the same system,
>> especially when sending-to-self.
>>
> 
> That is a special case which is not related to the discussion.
> We are talking about being able to setup a bridge and migrate the
> associated state from the ethernet device to the bridge.

Well, actually the intention was to discuss all the related issues.
I do agree with the proposal of the "inherit" made in userspace, but
I'd also like to know your opinion about the netfilter question I 
asked in another e-mail and this issue.

Thanks,
Pavel
