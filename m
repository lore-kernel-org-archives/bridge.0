Message-ID: <fed120860810020928y3e3dd3eag341b33b57fefd6db@mail.gmail.com>
Date: Thu, 2 Oct 2008 21:58:38 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <6f6192b30810020638q72016966pccfc0e7b9acb3db5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6f6192b30810010757j408cbcb7jd5ee33b8da832cbe@mail.gmail.com>
	<20081001173246.5ee6696e@speedy>
	<fed120860810011401i33a7d752qd5abf1490b3900f4@mail.gmail.com>
	<6f6192b30810020638q72016966pccfc0e7b9acb3db5@mail.gmail.com>
Subject: Re: [Bridge] RSTP location and GPL info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: M T <m.t.linuxbridge@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Thu, Oct 2, 2008 at 7:08 PM, M T <m.t.linuxbridge@gmail.com> wrote:
> Thanks a lot for the response.
>
> Can you please tell me how far is the original RSTP implementation from
> 802.1D-2004? The only reason I ask is to understand if the original library
> can be modified to suit my purposes.

RSTPLIB is based on something pretty close to the draft standard
802.1w-2001. (RSTPLIB is a bit older than 2001, but it is mostly the
same.) This is reasonably interoperable with other RSTP
implementations. The 802.1D-2004 bridge standard incorporates the
802.1w-2001 standard but with some further changes.
