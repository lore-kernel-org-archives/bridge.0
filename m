MIME-Version: 1.0
In-Reply-To: <20100822.213632.191389158.davem@davemloft.net>
References: <1282280596-18992-1-git-send-email-xiaosuo@gmail.com>
	<20100822.213632.191389158.davem@davemloft.net>
From: Changli Gao <xiaosuo@gmail.com>
Date: Mon, 23 Aug 2010 12:40:28 +0800
Message-ID: <AANLkTimCZKGvp9Mnr5Afwo1gRVcLPtYn9Z5=c9NYjm6y@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: netfilter: fix a memory leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Mon, Aug 23, 2010 at 12:36 PM, David Miller <davem@davemloft.net> wrote:
> From: Changli Gao <xiaosuo@gmail.com>
> Date: Fri, 20 Aug 2010 13:03:16 +0800
>
>> nf_bridge_alloc() always reset the skb->nf_bridge, so we should always
>> put the old one. skb->nf_bridge->use is initialized in nf_bridge_alloc()=
,
>> so we don't need to initialize it again.
>>
>> Signed-off-by: Changli Gao <xiaosuo@gmail.com>
>
> We just memcpy()'d 'nf_bridge' to 'tmp', that why the ->use count is
> going to be something other than '1'. =A0It now has the ->use count that
> 'nf_bridge' did.
>
> And that is why we must explicitly do atomic_set() on 'tmp'.
>

Oops, thanks. I'll post a update.


--=20
Regards,
Changli Gao(xiaosuo@gmail.com)
