MIME-Version: 1.0
In-Reply-To: <20110905094321.7e0f734c@nehalam.ftrdhcpuser.net>
References: <20110905145807.GA9179@chii>
	<20110905094321.7e0f734c@nehalam.ftrdhcpuser.net>
Date: Wed, 7 Sep 2011 15:33:13 +0800
Message-ID: <CAFhJ8JBPk1PM-sWrJrgTnOgZ02MXnYviWhVcs=Ht_bHpmdUC+Q@mail.gmail.com>
From: Xiaochen Wang <wangxiaochen0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] skip . and .. in accurately in isbridge()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Lennert Buytenhek <buytenh@gnu.org>, bridge@linux-foundation.org

On Tue, Sep 6, 2011 at 12:43 AM, Stephen Hemminger
<shemminger@vyatta.com> wrote:
> On Mon, 5 Sep 2011 22:58:07 +0800
> Xiaochen Wang <wangxiaochen0@gmail.com> wrote:
>
>> Hi all,
>>
>> =A0In commit f88f8 "Skip . and .. in foreach_bridge test", the code skip=
s
>> =A0all directories starting with dot.
>>
>> =A0But if we create a bridge staring with dot, e.g. `.br0`, then `brctl =
show`
>> =A0cannot show this one.
>> =A0`.br0` should not be hidden, because we cannot find it except the com=
mand
>> =A0`brctl show .br0`.
>>
>> Signed-off-by: Xiaochen Wang <wangxiaochen0@gmail.com>
>> ---
>> =A0libbridge/libbridge_init.c | =A0 =A07 +++++--
>> =A01 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/libbridge/libbridge_init.c b/libbridge/libbridge_init.c
>> index 1c1acbd..177a391 100644
>> --- a/libbridge/libbridge_init.c
>> +++ b/libbridge/libbridge_init.c
>> @@ -49,9 +49,12 @@ static int isbridge(const struct dirent *entry)
>> =A0 =A0 =A0 char path[SYSFS_PATH_MAX];
>> =A0 =A0 =A0 struct stat st;
>>
>> - =A0 =A0 if (entry->d_name[0] =3D=3D '.')
>> + =A0 =A0 if (entry->d_name[0] =3D=3D '.'
>> + =A0 =A0 =A0 =A0 && (entry->d_name[1] =3D=3D '\0'
>> + =A0 =A0 =A0 =A0 =A0 =A0 || (entry->d_name[1] =3D=3D '.'
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && entry->d_name[2] =3D=3D '\0')))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> -
>> +
>> =A0 =A0 =A0 snprintf(path, SYSFS_PATH_MAX,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSFS_CLASS_NET "%s/bridge", entry->d_nam=
e);
>> =A0 =A0 =A0 return stat(path, &st) =3D=3D 0 && S_ISDIR(st.st_mode);
>
> This was an accident originally, but allowing hidden bridges might be use=
ful.
> And is common for other commands to not show names starting with .
>
I see.
