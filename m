Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=nTfIM9eNSGKJ8QebLz/EL1nRM+ak2uWVNM6o/sMc+RE=;
	b=e6cSvZ2K+QvlN09dqC871yy0Q9J50buJX7HnV2c1EKSbMeAkrrvlFu4BRY6phzviaR
	Wc1/TBKkyVrseFwX6RdqbCgZaqs7pN9oeo8JdChA+3GDNcWoo4PFc75ovj9AReHZTYIr
	7W7t6kwpB+t0ob4blOeMJZCRZKNer+NNrW6pAsBcWeky2eWC+iBDXGlAlqZlZViN9a/w
	+0eg2SHMAz+9ciEovaW3vfl46/311YyvBpjt4oBf3LxqOWHTMa7IjODK7OvZRTbUmztB
	cByajyjvkOc2+fKkiYx29rOw8vosonrxH4PhTk6dV1/xC1kh/AocugGKpoUVBwb5YNhq
	9zDA==
Message-ID: <55897509.8010205@gmail.com>
Date: Wed, 24 Jun 2015 00:02:33 +0900
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
MIME-Version: 1.0
References: <1435062496-14596-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1435062496-14596-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: vlan: flush the dynamically
 learned entries on port vlan delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: vyasevich@gmail.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 15/06/23 (火) 21:28, Nikolay Aleksandrov wrote:
> Add a new argument to br_fdb_delete_by_port which allows to specify a
> vid to match when flushing entries and use it in nbp_vlan_delete() to
> flush the dynamically learned entries of the vlan/port pair when removing
> a vlan from a port. Before this patch only the local mac was being
> removed and the dynamically learned ones were left to expire.
> Note that the do_all argument is still respected and if specified, the
> vid will be ignored.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> note: There are 2 warnings, the C99 comment was already there and the 81
>        char line is the prototype and I think it looks better this way.
>        One unclear thing is about vid 0, I see that it can be passed to
>        nbp_vlan_(add|delete) although the comment says it shouldn't.

nbp_vlan_add() should not be called with vid 0 because vid 0 of fdb
entries is internally used when vlan_filtering is disabled, and such
entries are exposed to userspace as those without any vlan id.
bridge's vlan_filtering is respecting 802.1Q-2011 spec, which says vid 0
cannot be used as a normal vlan id.
If vlan 0 can be added, it should be a bug.

Toshiaki Makita
