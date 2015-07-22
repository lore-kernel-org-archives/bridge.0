Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=//W78a3KkgGv+qICih+gOFE5BrJDgnz4gUqJYH2Ufko=;
	b=hnC6y5P/RWpZ9BSTw6CqEam4VGaXgMhLbO/qO37pTjTpUsUOgF24SLFuGs6M35Rg9j
	9k8Dh+cp1ZtnYm945YKrFlvqPehcI/6Uz5kjT+7NQrC2bMpg9nN8gzE0NAa8x7VP+Rge
	JjSj0oyTyK0BcVIqjzHKqshrL/Wa7kpGj4ogg=
References: <1437560929-25827-1-git-send-email-nikolay@cumulusnetworks.com>
	<CAHA+R7PTV5aTk2JyaaCQ1awi_Cwz+jzA4tv9n2nEvaFxhuD0Pg@mail.gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <55AFDA89.1080304@cumulusnetworks.com>
Date: Wed, 22 Jul 2015 20:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAHA+R7PTV5aTk2JyaaCQ1awi_Cwz+jzA4tv9n2nEvaFxhuD0Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mcast: when multicast is
 disabled flush the groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <cwang@twopensource.com>
Cc: netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, David Miller <davem@davemloft.net>

On 07/22/2015 07:03 PM, Cong Wang wrote:
> On Wed, Jul 22, 2015 at 3:28 AM, Nikolay Aleksandrov
> <nikolay@cumulusnetworks.com> wrote:
>> From: Satish Ashok <sashok@cumulusnetworks.com>
>>
>> Once multicast gets disabled we should flush the groups.
>> Example:
>> # bridge mdb add dev br0 port eth3 grp 239.0.0.1
>> # bridge mdb
>> dev br0 port eth3 grp 239.0.0.1 temp
>> # echo 0 > multicast_snooping
>> # bridge mdb
> 
> Why? Why we can't save the mdb config for a mcast snooping flip?
> 

Right, I've discussed this with my colleagues and we think this doesn't have any
value for upstream and shouldn't have been sent which is bad judgment on my side.
It actually makes things worse because it removes the user's permanent entries on
snooping disable and it may happen automatically by hash exhaustion.

Anyway, please drop this patch and sorry for the noise, I should've given this
change more thought.

Thanks,
 Nik
