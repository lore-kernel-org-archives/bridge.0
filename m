Return-Path: <arend@broadcom.com>
Message-ID: <524BCAC4.6060209@broadcom.com>
From: "Arend van Spriel" <arend@broadcom.com>
MIME-Version: 1.0
References: <1380679480.2081.24.camel@joe-AO722>
In-Reply-To: <1380679480.2081.24.camel@joe-AO722>
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net:drivers/net: Miscellaneous
 conversions to ETH_ALEN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 02 Oct 2013 07:27:17 -0000
To: Joe Perches <joe@perches.com>, netdev <netdev@vger.kernel.org>
Cc: bridge@lists.linux-foundation.org, e1000-devel@lists.sourceforge.net, brcm80211-dev-list@broadcom.com, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, ath10k@lists.infradead.org, wil6210@qca.qualcomm.com, netfilter-devel <netfilter-devel@vger.kernel.org>, b43-dev@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On 10/02/2013 04:04 AM, Joe Perches wrote:
> Convert the memset/memcpy uses of 6 to ETH_ALEN
> where appropriate.
>
> Also convert some struct definitions and u8 array
> declarations of [6] to ETH_ALEN.
>
For brcmsmac

Acked-by: Arend van Spriel <arend@broadcom.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   drivers/net/wireless/brcm80211/brcmsmac/main.c     |  6 +-


