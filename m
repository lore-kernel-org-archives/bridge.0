Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=KcUMF9RvxBnidL65EdXls+n0clS5oze0F6lmaqg8m/Q=;
	b=zyJ+i8APS6QOYfBw6ls3PRQK2621EkQvRB8JNUdeUMNaJoqNVwjfOmS4u8iQ4tScuB
	dKoEHq2KOxZjVtLVvEbNEPBXCxC5puEQQO5zVDVJpoE18yjz2hDpVin33EDuRxfBpz6/
	PqUz6UpIwPIY8+4gjYgLFIj5j9l4e5y4q341NlsmxjnoLzbpLpDYHTHByJpptPHKbmPz
	OFEQ+q+EQNtpxSknD3jJ6YmNLoLRzZ+ttM0OUF0h0PHNht98vxUKI9Ofb/er9kfnfx1u
	Ur+KeDIxcnfbuKbiVpXf2oY1oRrZeiXolOPZUjGTmS7z4DXXevqZZFpKVS0696hw70+9
	XHDw==
MIME-Version: 1.0
In-Reply-To: <56E96DFC.7090608@cumulusnetworks.com>
References: <cover.1458134414.git.lucien.xin@gmail.com>
	<56E96DFC.7090608@cumulusnetworks.com>
Date: Wed, 16 Mar 2016 22:59:37 +0800
Message-ID: <CADvbK_ce_0p8j4pi3wQ6OkYWVZOde6guhGKdJ49H0W228df27g@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next 0/6] bridge: support sending rntl info
 when we set attributes through sysfs/ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: network dev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem <davem@davemloft.net>

On Wed, Mar 16, 2016 at 10:30 PM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> On 03/16/2016 02:34 PM, Xin Long wrote:
>> This patchset is used to support sending rntl info to user in some places,
>> and ensure that whenever those attributes change internally or from sysfs,
>> that a netlink notification is sent out to listeners.
>>
>> It also make some adjustment in bridge sysfs so that we can implement this
>> easily.
>>
>> I've done some tests on this patchset, like:
>> [br_sysfs]
>>   1. change all the attribute values of br or brif:
>>   $ echo $value > /sys/class/net/br0/bridge/{*}
>>   $ echo $value > /sys/class/net/br0/brif/eth1/{*}
>>
>>   2. meanwhile, on another terminal to observe the msg:
>>   $ bridge monitor
>>
>> [br_ioctl]
>>   1. in bridge-utils package, do some changes in br_set, let brctl command
>>   use ioctl to set attribute:
>>          if ((ret = set_sysfs(path, value)) < 0) { -->
>>          if (1) {
>>
>>   $ brctl set*
>>
>>   2. meanwhile, on another terminal to observe the msg:
>>   $ bridge monitor
>>
>> This test covers all the attributes that brctl and sysfs support to set.
>>
>
> Please also include the bridge maintainers (CCed).
>
okay,  I will post v2 with CC maintainers.
thanks
