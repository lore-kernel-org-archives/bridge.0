Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eq8Q3Wf36/Ac2wsVD
 zrJSDqU/+NPSnDNknTC94Rn3ys=; b=Z+u61UZF2MpFvWSlO9RK9pImFvyFmJi45
 jy6JXcXuXSm3frv6E3GS/SPdGVUx5jdEEFQ+QqdpGZu7HAE6uNYkS9LgMYaQn6Zk
 cRRvPrhYr46PgsDMZ0jQskLD2kuL7U6XppwJNiCHbvB3SxYso8QLkVtRg5Km+CWJ
 +1xP7shOd/FYQ7MTQdkVOZ4nJ5EuGNWy65PAxIBkgpphPWlQKfGyF+RCr0BJocYu
 qpUyh1nzzUhRZPMb7oJAfWWKpsc/EEoUvnPYjgH55dqG/yctgtg5MnjHJHJPuQio
 FPPlokROP7Nb3zWA9Rdjw0C02G7ih2Fp8snt5Brdtr6g8AwFYLxVQ==
Date: Thu, 17 Mar 2022 16:59:30 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YjNM0ugG2dcZSD2r@shredder>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-2-schultz.hans+netdev@gmail.com>
 <YjM7Iwx4MDdGEHFA@shredder> <86ilsciqfh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ilsciqfh.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Mar 17, 2022 at 03:50:26PM +0100, Hans Schultz wrote:
> On tor, mar 17, 2022 at 15:44, Ido Schimmel <idosch@idosch.org> wrote:
> > On Thu, Mar 17, 2022 at 10:38:59AM +0100, Hans Schultz wrote:
> >> Add an intermediate state for clients behind a locked port to allow for
> >> possible opening of the port for said clients. This feature corresponds
> >> to the Mac-Auth and MAC Authentication Bypass (MAB) named features. The
> >> latter defined by Cisco.
> >> Only the kernel can set this FDB entry flag, while userspace can read
> >> the flag and remove it by deleting the FDB entry.
> >
> > Can you explain where this flag is rejected by the kernel?
> >
> Is it an effort to set the flag from iproute2 on adding a fdb entry?

I'm not sure what you are asking, but even if iproute2 can't set the
flag it doesn't mean the kernel shouldn't reject it

> 
> > Nik, it seems the bridge ignores 'NDA_FLAGS_EXT', but I think that for
> > new flags we should do a better job and reject unsupported
> > configurations. WDYT?
> >
> > The neighbour code will correctly reject the new flag due to
> > 'NTF_EXT_MASK'.
