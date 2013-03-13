Return-Path: <stephen@networkplumber.org>
Date: Wed, 13 Mar 2013 15:54:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20130313155450.61886850@nehalam.linuxnetplumber.net>
In-Reply-To: <20130313203333.GC9821@redhat.com>
References: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
	<1363139126-13396-3-git-send-email-vyasevic@redhat.com>
	<20130313203333.GC9821@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/4] bridge: Allow an ability to
 designate an uplink port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Wed, 13 Mar 2013 22:33:33 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 12, 2013 at 09:45:24PM -0400, Vlad Yasevich wrote:
> > Allow a ports to be designated as uplink.  Multiple ports
> > may be designated as uplinks and they will be kept in a
> > list.
> > 
> > Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> 
> It looks like if you make two links uplink, bridging
> between them won't work at all?

Maybe better to mark which ports are terminal ports rather than marking
uplink ports?
