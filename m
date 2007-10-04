Date: Thu, 4 Oct 2007 14:33:44 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Encountered a segfault after executing "brctl stp
	show" command
Message-ID: <20071004143344.0d1518e9@freepuppy.rosehill>
In-Reply-To: <200710041017.l94AHrH7031701@mail.calsofthq.com>
References: <200710041017.l94AHrH7031701@mail.calsofthq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dhananjay <dhananjay.tembe@calsoftinc.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 4 Oct 2007 15:48:18 +0530
"Dhananjay" <dhananjay.tembe@calsoftinc.com> wrote:

> Hi,
> 
>          I was playing with the brctl utility and typed wrong brctl command:
> brctl show stp
>

Fixed long ago.

The distribution is shipping an old version of bridge utils:
RHEL ships some old version probably 1.0.
Version shipped by Fedora core 7 is 1.1
Current version is 1.2

Repository:
	git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
