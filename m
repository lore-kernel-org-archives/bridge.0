Return-Path: <amine.kherbouche@6wind.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=6wind-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=bMVQdxen3Igriv1B0Y6D8yJQhI867sZT56Se2nH4IvA=;
	b=DbU0qgZVK1Rb/9K7gp8eOaDg8hpr4WIXxylvhPdLdsBklExlcjaUcfCK4RTMXPt8yI
	eT2S4zS7zfsrCpghx5RMbaKsxwBLboD+/JZ/Y0vdncI5x+T9DSFUD076VLQh5KaZ0u8I
	rj9+TTuhGQxRsuBSkzN9QYMBdsYofA8FqZjKzVRh4GRpH9A1fSBXDxd3JT2iIgS5BxXN
	lpP3zRenYvTvx+TOZVVE+Z/rAAOjNiF0t2XZjAruB3vgI4yMcFvV4lcmnCQsXg1DSbmV
	TGPmwMq5apoWyr5++IIl/XjUI2NBZh8tLq2oJMkLYnI5EDb2DaSQD7V3a3MnrSHWvYdl
	jfCw==
References: <20170821171523.951260-1-equinox@diac24.net>
	<6a538120-1941-7e81-c942-e97adeff2e3d@6wind.com>
From: Amine Kherbouche <amine.kherbouche@6wind.com>
Message-ID: <6b7cdb61-9c24-3fcb-d23c-f08ca2144ec9@6wind.com>
MIME-Version: 1.0
In-Reply-To: <6a538120-1941-7e81-c942-e97adeff2e3d@6wind.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next v2] bridge lwtunnel, VPLS & NVGRE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 19 Sep 2017 14:46:52 -0000
To: David Lamparter <equinox@diac24.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: roopa@cumulusnetworks.com

Hi David,

What's next ? do you plan to send a v3 or should I do it ?

On 09/11/2017 10:02 AM, Amine Kherbouche wrote:
> Hi David,
>
> Do you plan to send a v3?
>
> On 21/08/2017 18:15, David Lamparter wrote:
>> Hi all,
>>
>>
>> this is an update on the earlier "[RFC net-next] VPLS support".  Note
>> I've changed the subject lines on some of the patches to better reflect
>> what they really do (tbh the earlier subject lines were crap.)
>>
>> As previously, iproute2 / FRR patches are at:
>> - https://github.com/eqvinox/vpls-iproute2
>> - https://github.com/opensourcerouting/frr/commits/vpls
>> while this patchset is also available at:
>> - https://github.com/eqvinox/vpls-linux-kernel
>> (but please be aware that I'm amending and rebasing commits)
