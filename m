Date: Mon, 8 Mar 2010 23:22:57 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100308232257.2e5aa253@nehalam>
In-Reply-To: <2e59e6971003081403saf30ca4od0e25757f099d889@mail.gmail.com>
References: <1826249814.390491268083744068.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1883282645.390611268083800046.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8f2d78ba1003081332v539dbebeo7b6ef46f2c48c620@mail.gmail.com>
	<2e59e6971003081403saf30ca4od0e25757f099d889@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Fwd: What is the lowest valid MAC address that can be
 assigned to a NIC/bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 8 Mar 2010 16:03:15 -0600
"richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote:

> The "lowest valid MAC address" is assuredly not unique to the host,
> which I would think rather defeats the purpose of using it as an
> address.

Agreed. I would choose one of the existing interfaces and set
that value explicitly.


-- 
