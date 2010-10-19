Date: Mon, 18 Oct 2010 20:28:58 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101018202858.7342f2cb@nehalam>
In-Reply-To: <1287454175-22903-1-git-send-email-benjamin.poirier@polymtl.ca>
References: <20101018093837.26bb149a@nehalam>
	<1287454175-22903-1-git-send-email-benjamin.poirier@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Forward reserved group addresses if
	!STP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Poirier <benjamin.poirier@polymtl.ca>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Pirko <jpirko@redhat.com>, Jiri, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>, "David S. Miller" <davem@davemloft.net>

On Mon, 18 Oct 2010 22:09:35 -0400
Benjamin Poirier <benjamin.poirier@polymtl.ca> wrote:

> Make all frames sent to reserved group MAC addresses (01:80:c2:00:00:00 to
> 01:80:c2:00:00:0f) be forwarded if STP is disabled. This enables
> forwarding EAPOL frames, among other things.
> 
> Signed-off-by: Benjamin Poirier <benjamin.poirier@polymtl.ca>

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
