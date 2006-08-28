Date: Mon, 28 Aug 2006 09:54:50 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060828095451.0896171f@localhost.localdomain>
In-Reply-To: <20060826174128.GA5052@pul.manty.net>
References: <20060826174128.GA5052@pul.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] patch for a message bug
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Sat, 26 Aug 2006 19:41:28 +0200
Santiago Garcia Mantinan <bridge@manty.net> wrote:

> Hi!
> 
> Jens Seidel reported a bug to Debian about a wrong message on brctl, you can
> see it at http://bugs.debian.org/383938, it is kind of the continuation of
> the ENODEV bug #348617 that was already patched by Stephen on the git.
> 
> I have applied the same solution that Stephen applied for the first one,
> follows the patch against git plus a minor exclamation mark modification I
> did so that all ENODEV messages were exclamative (Stephen patch had missed
> that mark).
> 
> Regards...
Applied to current git tree, will show up in next version

-- 
Stephen Hemminger <shemminger@osdl.org>

All non-trivial abstractions, to some degree, are leaky.
