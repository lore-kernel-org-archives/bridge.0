Return-Path: <pr-tracker-bot@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1749B82154
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 564608148F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693367887;
 bh=mPKk2+swFtGFWy8pTYH1vfYUh7/3u0eFDl38x3vBbbc=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=ADgZbQkup9SM4uuEjVXPl0kZb5qU5cRxcBUYIV68ssaOHHCZrS2+ntwfLz0HT21Ih
 e386cEZAZNnNJznyld2KJf/v8fe7MjFSYHeqn2jCi/au5X8+GFJAJs2UqaMkjl13Pt
 tBWufYtEAuzWRPX8V1l2CtngKltT6f7/s0ANkfkNNyVfix0L9B91QYMTHLJdOVoFVq
 IlamCyGNhuWsTR9+yFkPDS5wrnr9z9xFHderl/6D+AsGosodrxgWcJDG1GU30wgN9F
 bxisMSAemfMVycuM7wn1I11u7D6rtj9+5B2G88KHjzTBzjQzbN1UyndsBWNsRv7wH+
 v1R8ONmU6MaSg==
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
References: <ZO5Yx5JFogGi/cBo@bombadil.infradead.org>
Message-Id: <169336788741.6268.886734446514047714.pr-tracker-bot@kernel.org>
Date: Wed, 30 Aug 2023 03:58:07 +0000
Subject: Re: [Bridge] [GIT PULL] sysctl changes for v6.6-rc1
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, coreteam@netfilte, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, bridge@lists.linux-foundation.org, willy@infradead.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, Iurii Zaikin <yzaikin@google.com>, r.org@osuosl.org, Wen Gu <guwen@linux.alibaba.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Joerg Reuter <jreuter@yaina.de>, Sven Schnelle <svens@linux.ibm.com>, Joel Granados <joel.granados@gmail.com>, keescook@chromium.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Roopa Prabhu <roopa@nvidia.com>, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Karsten Graul <kgraul@linux.ibm.com>, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

The pull request you sent on Tue, 29 Aug 2023 13:44:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adfd671676c922bada16477eb68b5eb5f065addc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
