MIME-Version: 1.0
In-Reply-To: <1287550779.10409.620.camel@Joe-Laptop>
References: <1287543276-4511-1-git-send-email-xiaosuo@gmail.com>
	<1287543701.10409.599.camel@Joe-Laptop>
	<AANLkTi=pz4zYnnUSvb9FjVvCAURruHhJTz7pBKDi8Pdw@mail.gmail.com>
	<1287545337.10409.602.camel@Joe-Laptop>
	<AANLkTimGUB-+TTsje1kc3q9PyoB2jJdgCK2Z7n9u7N1J@mail.gmail.com>
	<1287550779.10409.620.camel@Joe-Laptop>
From: Changli Gao <xiaosuo@gmail.com>
Date: Wed, 20 Oct 2010 13:10:27 +0800
Message-ID: <AANLkTi=wtc3uAqP6zq4XN-_kLaDhaPNB+BxkwkFbpxj4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] [PATCH] net: make ctl_path local and const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: Andy Grover <andy.grover@oracle.com>, linux-sctp@vger.kernel.org, rds-devel@oss.oracle.com, "Pekka Savola (ipv6)" <pekkas@netcore.fi>, linux-x25@vger.kernel.org, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, coreteam@netfilter.org, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Joerg Reuter <jreuter@yaina.de>, Sridhar Samudrala <sri@us.ibm.com>, Samuel Ortiz <samuel@sortiz.org>, Vlad Yasevich <vladislav.yasevich@hp.com>, netfilter@vger.kernel.org, Remi Denis-Courmont <remi.denis-courmont@nokia.com>, linux-hams@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>

On Wed, Oct 20, 2010 at 12:59 PM, Joe Perches <joe@perches.com> wrote:
>
> Not using static requires the compiler to emit
> initialization code for any use of the routine
> that otherwise would only be done once.
>

If the code isn't performance critical, I think we can afford.
Otherwise, we have to reserve the memory used to save the static data,
if we don't specify it as initial data.

-- 
Regards,
Changli Gao(xiaosuo@gmail.com)
