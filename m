Return-Path: <william.kucharski@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=idOepDtgJ7tjD1tjKHB6BFOc3UICwOu0C0kHa1ZpCG8=;
	b=npaSBprRz0uOZdg0rgPAjpTkGj13a7JxbYUmcm/kgSYN6HYa21oEi6ZBeeU4oAO+DKTp
	taNYRHFq73Ydx5//ZnxTFeqQxeYhr6cOOGmK4LPdlNmv0oGU2JjrlH2cLoe1BxDsI771
	bwzKfTOq256s+/2GtsM6dafNn76w+Daj5Wp8iTZ3LZLEi21qZ/lVjW4Z2bK9YK08Beqw
	wP08rN7SERACNJzCY7xSgOAtJgyrEH2dFnE840W3Y8h+p6OXgVW4txsXXjKF5AX1lRcv
	8/0UX/CMd5PZP1+HcY8nTLVB0lvFBmXqbRXdn+MTpssyc1M43YnSwW0V4CRGQ3wF2hDT
	qQ== 
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190103031431.247970-1-shakeelb@google.com>
Date: Thu, 3 Jan 2019 03:14:56 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <313C6566-289D-4973-BB15-857EED858DA3@oracle.com>
References: <20190103031431.247970-1-shakeelb@google.com>
Subject: Re: [Bridge] [PATCH v2] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Shakeel Butt <shakeelb@google.com>
Cc: coreteam@netfilter.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrew Morton <akpm@linux-foundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>



> On Jan 2, 2019, at 8:14 PM, Shakeel Butt <shakeelb@google.com> wrote:
>=20
> 	countersize =3D COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
> -	newinfo =3D vmalloc(sizeof(*newinfo) + countersize);
> +	newinfo =3D __vmalloc(sizeof(*newinfo) + countersize, =
GFP_KERNEL_ACCOUNT,
> +			    PAGE_KERNEL);
> 	if (!newinfo)
> 		return -ENOMEM;
>=20
> 	if (countersize)
> 		memset(newinfo->counters, 0, countersize);
>=20
> -	newinfo->entries =3D vmalloc(tmp.entries_size);
> +	newinfo->entries =3D __vmalloc(tmp.entries_size, =
GFP_KERNEL_ACCOUNT,
> +				     PAGE_KERNEL);
> 	if (!newinfo->entries) {
> 		ret =3D -ENOMEM;
> 		goto free_newinfo;
> --=20

Just out of curiosity, what are the actual sizes of these areas in =
typical use
given __vmalloc() will be allocating by the page?

   =20

