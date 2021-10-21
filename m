Return-Path: <keescook@chromium.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5RyUrXEQJgkpkS3LgGmg7QZzk/Xp6vh/AxqTCLe3xyo=;
 b=KrRrga5C/YO2dLe0TvqzGlGSYEQLjNmER7uhbG0b9kkxrtdRmWn1Nr9EZRKoCnCX6I
 t4NUngrX6gaK3GG/PDiRpl8xDbd2VtNkJLVHb7tdhwFJ+uypWCHF38OcH5/A2L2fMC6I
 vu+ScOMVCSX4SUjMU26XP9cvq+DRQoarq3J98=
Date: Thu, 21 Oct 2021 10:00:34 -0700
From: Kees Cook <keescook@chromium.org>
Message-ID: <202110210958.6626A30@keescook>
References: <20210928200647.GA266402@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928200647.GA266402@embeddedor>
Subject: Re: [Bridge] [PATCH][net-next] netfilter: ebtables: use
 array_size() helper in copy_{from, to}_user()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>, linux-hardening@vger.kernel.org

On Tue, Sep 28, 2021 at 03:06:47PM -0500, Gustavo A. R. Silva wrote:
> Use array_size() helper instead of the open-coded version in
> copy_{from,to}_user().  These sorts of multiplication factors
> need to be wrapped in array_size().
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

I see that this is marked "Awaiting Upstream" (for an ebtables
maintainer ack?)
https://patchwork.kernel.org/project/netdevbpf/patch/20210928200647.GA266402@embeddedor/

-- 
Kees Cook
