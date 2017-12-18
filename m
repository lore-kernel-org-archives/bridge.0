Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ou3Ywv2NOepBYUBI4utpAqK+6VXYxETd7OkuU2MAumM=;
	b=KVexisO/+f9iEKqP8hiLteJgYLjJykQakmSj+qolWK7IQHUDFcOFLTCdBPxOcsfq8l
	rhncxT6NDZnCpfj06YMxU45ywt2ClF/lKhAMOjmdzj8Ca0oMsIjH42CGwIvbIyzPmKKs
	IAJAzfsQyBFwy725ExHiznk4FKHvq7IkVoEnk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <73a472e3-e521-1930-0643-a6f2714db6ce@cumulusnetworks.com>
	<1513423896-30294-1-git-send-email-nikolay@cumulusnetworks.com>
	<0d66d7ab-2837-afcb-430f-32f6e4a5d675@lab.ntt.co.jp>
	<4b07ce51-177d-df6f-f5ac-321f85402b6c@cumulusnetworks.com>
Message-ID: <e4948ab7-0f3b-a4f5-52ea-853a987f1abb@cumulusnetworks.com>
Date: Mon, 18 Dec 2017 16:23:55 +0200
MIME-Version: 1.0
In-Reply-To: <4b07ce51-177d-df6f-f5ac-321f85402b6c@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix early call to
 br_stp_change_bridge_id
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, roopa@cumulusnetworks.com, avagin@gmail.com, davem@davemloft.net

On 12/18/2017 04:22 PM, Nikolay Aleksandrov wrote:
> On 12/18/2017 04:24 AM, Toshiaki Makita wrote:
>> On 2017/12/16 20:31, Nikolay Aleksandrov wrote:
> [snip]
>> ...
>>>  	err = br_changelink(dev, tb, data, extack);
>>> -	if (err)
>>> +	if (err) {
>>> +		/* clean possible fdbs from br_stp_change_bridge_id above */
>>> +		br_fdb_delete_by_port(br, NULL, 0, 1);
>>
>> Don't we need to call br_dev_delete (br_link_ops.dellink) after
>> successful register instead of br_fdb_delete?
>> Particularly I'm wondering if not calling br_sysfs_delbr() is ok or not.
>>
> 
> Funny, that is actually the only reason we need to call it (br_sysfs_delbr). :-)
> 
> Good catch, that is another leak - the bridge sysfs entries are registered when
> NETDEV_REGISTER event happens (register_netdevice) but are not properly cleaned up
> on error there. This has also been present since the introduction of changelink
> during newlink, commit:
>  b6677449dff6 ("bridge: netlink: call br_changelink() during br_dev_newlink()")

err, since the changelink was fixed to be after device registration in commit:
 5b8d5429daa0 ("bridge: netlink: register netdevice before executing changelink")

> 
> I'll send v2 that does br_dev_delete(dev, NULL) instead of the current cleanup.
> With kobject debug enabled and that I can see "brif" and the rest of the sysfs
> files getting freed properly, while before they weren't.
> 
> Thanks,
>  Nik
> 

