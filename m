Message-ID: <bdfc5d6e0806120622i7f55f960t891f8831ec71879b@mail.gmail.com>
Date: Thu, 12 Jun 2008 09:22:53 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
In-Reply-To: <E88155B5BD67CE4D87A3F1F70950B96A2FF8AE@berta.maurer-it.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>
	<20080611085859.721e3917@extreme>
	<E88155B5BD67CE4D87A3F1F70950B96A2FF8AA@berta.maurer-it.com>
	<4850FA96.1050205@trash.net>
	<E88155B5BD67CE4D87A3F1F70950B96A2FF8AE@berta.maurer-it.com>
Subject: Re: [Bridge] Bridge MAC selection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: bridge@lists.linux-foundation.org

On Thu, Jun 12, 2008 at 7:10 AM, Dietmar Maurer <dietmar@proxmox.com> wrote:
>>>> There any side effects with the following patch?
>>> Not for you. But if it got changed now, it would surprise the
>>> existing users (change in ABI behaviour).
>
> If there are no other side effects, I wonder whats better:
>
> A.) unexpected Network failures due to mac changes
>
> B.) surprised users (does anybody depend on such behavour?)
>
> I vote for A.)
>
> - Dietmar
>

You might think A is a better option, but option B is frowned upon.  I
understand you desire your change the behavior to meet your needs, but
Patrick's suggestion to add a module parameter to tweak this behavior
based on a module option is probably better than simply changing the
existing functionality to meet your needs.
