Date: Thu, 18 Aug 2011 08:10:19 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110818081019.4b9bb79e@nehalam.ftrdhcpuser.net>
In-Reply-To: <CAEJpZP0fOydMMbgquAud7dfwcO28BXAMzAwnMjSZO6TvEjxgpQ@mail.gmail.com>
References: <CAF5U64C+WgQhfJL3zfVnvzE7p=G61humQCObHGUxAvY2-MGAFQ@mail.gmail.com>
	<CAF5U64CJTWDn8E9+XVLFsdaSbiu-4Rd9XmxZq7ReziRNZviO6Q@mail.gmail.com>
	<20110812154545.79d8313f@nehalam.ftrdhcpuser.net>
	<CAF5U64B_fb2tFMLHmK+zw3n6gmq+bYDyFnXhLE0ayssK5m+THA@mail.gmail.com>
	<20110815150501.3a6cc432@nehalam.ftrdhcpuser.net>
	<CAEJpZP0fOydMMbgquAud7dfwcO28BXAMzAwnMjSZO6TvEjxgpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] bridge: allow passing link-local multicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nick Carter <ncarter100@gmail.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, Ed Swierk <eswierk@bigswitch.com>, David Lamparter <equinox@diac24.net>

On Thu, 18 Aug 2011 16:06:19 +0100
Nick Carter <ncarter100@gmail.com> wrote:

> Why can't we use the 802.1D specified STP group address to identify ?
> The existing code uses that address.
> I know you said on another thread that there are people using other addresses.
> Who are these people ?
> Are they following any standard ?
> What address / address range are they using ?

The group address can be reprogrammed, and it is settable on other
routing equipment. People do it to create spanning tree domains.
