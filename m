Return-Path: <pneira@us.es>
Date: Thu, 23 May 2013 12:56:00 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20130523105600.GA22553@localhost>
References: <5195E53A.4060406@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5195E53A.4060406@asianux.com>
Subject: Re: [Bridge] [PATCH] bridge: netfilter: using strlcpy() instead of
	strncpy()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Chen Gang <gang.chen@asianux.com>
Cc: coreteam@netfilter.org, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, stephen@networkplumber.org, netfilter@vger.kernel.org, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, kaber@trash.net

On Fri, May 17, 2013 at 04:07:22PM +0800, Chen Gang wrote:
> 
> 'name' has already set all zero when it is defined, so not need let
> strncpy() to pad it again.
> 
> 'name' is a string, better always let is NUL terminated, so use
> strlcpy() instead of strncpy().

Applied, thanks.
