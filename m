Return-Path: <forwardinglnx@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=HmkwHNnm96lqM33+cjiOOqCHbXYxqVdPpohl2MBHJh4=;
	b=DXnMTXyZx3bRO6JFhmgimZCQOXf0C5QVn7oQOJwPVOPYbuGnk1holjEKhEUk2jMVk4
	GA9ghvwS35NCB4flt0g+U8FvRQhx03MqYoRV8IHAqGn8Tn8t3X3L788hXGeX+XR9Bz/+
	O7nhLhI73tsKW5Eh/SlVK1LPJf5CqYV9IyNQ6/+euosEwG2JX78K61x451xUaU0RN8+j
	LtrdcSO1CJbVUebXZoGD6xvW5er1K9mQgHTCWM9ZPRnS3Yqm9NXXomfIpzxF1K3Qh1b1
	yO48bMECMbeT8YfEjdCYIAVFlmEd+VIk3/OpsLLde8XEBG6iItqbQty/c2qUp5Xsgck0
	P5dA==
MIME-Version: 1.0
In-Reply-To: <e6143108-3eb4-6f6a-c58b-857722f706b9@lab.ntt.co.jp>
References: <CA+N+6-xY7+coc6zFqzP665WMhbGFFMHOfre9wNxRAcSF2Bthzw@mail.gmail.com>
	<e6143108-3eb4-6f6a-c58b-857722f706b9@lab.ntt.co.jp>
From: Manohar Kumar <forwardinglnx@gmail.com>
Date: Wed, 24 May 2017 11:05:54 -0700
Message-ID: <CA+N+6-xtSgQ4eDN7SBMg43WXEc=6quPNE4L1-3xjLuTMte0DSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] Deleting a dynamic mac entry..
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Thanks, Toshiaki.

What is the right way to set the default_pvid using the bridge command
? I tried this, which fails..

root@net-3:~# ip link set dev vxlan0 name untagged type vlan id 0
RTNETLINK answers: Operation not supported
root@net-3:~#

All the interfaces in the bridge are untagged.

thanks,
Manohar.


On Mon, May 22, 2017 at 8:17 PM, Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
> On 2017/05/21 11:28, Manohar Kumar wrote:
>> Hello,
>>
>> In 3.19 the following bridge fdb command to delete a dynamically
>> learned entry fails..
>>
>> root@net-3:~# bridge fdb show | grep 02:42:0a:ff:00:06
>> 02:42:0a:ff:00:06 dev vxlan0 master br0
>> root@net-3:~# bridge fdb del 02:42:0a:ff:00:06 dev vxlan0 master
>> RTNETLINK answers: No such file or directory
>>
>> It works in 4.4.
>>
>> Can someone please point to the patch that made this change ?
>
> 25d3b493a52d ("bridge: Fix inability to add non-vlan fdb entry") might
> be what you are looking for, but you might want to do git-bisect to
> track down any regression or fix.
>
>> In kernels without this patch is there an alternative to delete
>> (actually I want to do it programmatically) dynamic mac entries ?
>
> If 25d3b493a52d is causing your problem, set default_pvid to 0 in order
> to disable default_pvid, and delete any vlans which is already
> configured in bridge's vlan_filtering. Then, delete the fdb entry.
>
> Toshiaki Makita
>
