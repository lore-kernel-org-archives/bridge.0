Return-Path: <pneira@us.es>
Date: Thu, 1 Oct 2015 00:17:07 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20150930221707.GA14994@salvia>
References: <1443089406-8996-1-git-send-email-ipm@chirality.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1443089406-8996-1-git-send-email-ipm@chirality.org.uk>
Subject: Re: [Bridge] [PATCH nf-next] netfilter: Line layout whitespace fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ian Morris <ipm@chirality.org.uk>
Cc: bridge@lists.linux-foundation.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org

On Thu, Sep 24, 2015 at 11:10:06AM +0100, Ian Morris wrote:
> Fixes various whitespace issues detected by checkpatch (e.g. adding spaces between operations, replacing spaces with tabs, etc)
> 
> No changes detected by objdiff.

These large cleanup patch causes problems for -stable maintainers,
since they have more conflicts when backporting stuff.

I'd rather keep this back.
