Date: Mon, 8 Feb 2010 15:47:35 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20100208154735.1d60f43c@nehalam>
In-Reply-To: <20100208142044.6be97024.akpm@linux-foundation.org>
References: <20100206165351.GA9411@localhost>
	<20100208142044.6be97024.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] PROBLEM: oops w/ bridge in 2.6.32.7
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Linux Kernel-Liste <linux-kernel@vger.kernel.org>, lkml@Think-Future.de

On Mon, 8 Feb 2010 14:20:44 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> > virtualbox-ose              3.1.2-dfsg-1+b1
> > virtualbox-ose-source       3.1.2-dfsg-1
> > 


Sorry, since virtualbox is not part of standard mainline kernel,
I suspect the problem is there.
Please reproduce with standard 2.6.32.X distribution.
