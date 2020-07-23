Return-Path: <jengelh@inai.de>
Date: Thu, 23 Jul 2020 17:40:49 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
In-Reply-To: <20200723060908.50081-5-hch@lst.de>
Message-ID: <nycvar.YFH.7.77.849.2007231725090.11202@n3.vanv.qr>
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH 04/26] net: add a new sockptr_t type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Netfilter Developer Mailing List <netfilter-devel@vger.kernel.org>, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


On Thursday 2020-07-23 08:08, Christoph Hellwig wrote:
>+typedef struct {
>+	union {
>+		void		*kernel;
>+		void __user	*user;
>+	};
>+	bool		is_kernel : 1;
>+} sockptr_t;
>+
>+static inline bool sockptr_is_null(sockptr_t sockptr)
>+{
>+	return !sockptr.user && !sockptr.kernel;
>+}

"""If the member used to access the contents of a union is not the same as the
member last used to store a value, the object representation of the value that
was stored is reinterpreted as an object representation of the new type (this
is known as type punning). If the size of the new type is larger than the size
of the last-written type, the contents of the excess bytes are unspecified (and
may be a trap representation)"""

As I am not too versed with the consequences of trap representations, I will
just point out that a future revision of the C standard may introduce (proposal
N2362) stronger C++-like requirements; as for union, that would imply a simple:

"""It's undefined behavior to read from the member of the union that wasn't
most recently written.""" [cppreference.com]


So, in the spirit of copy_from/to_sockptr, the is_null function should read

{
	return sockptr.is_kernel ? !sockptr.user : !sockptr.kernel;
}

