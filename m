Date: Wed, 26 Sep 2007 08:37:05 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070926083705.6bc65ea5@fujitsu-loaner>
In-Reply-To: <46FA2C17.76E4.0078.0@novell.com>
References: <46FA2C17.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] Module use count must be updated as bridges are
 created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Beulich <jbeulich@novell.com>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, 26 Sep 2007 08:53:27 +0100
"Jan Beulich" <jbeulich@novell.com> wrote:

> Otherwise 'modprobe -r' on a module having a dependency on bridge will
> implicitly unload bridge, bringing down all connectivity that was
> using bridges.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>

No, network devices don't do reference counting.
What is the dependency? Where is the source of the module interacting
with the  bridge?
